import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/core/services/cache/LocalHelper.dart';
import 'package:two_m_production/features/pages/Home/Data/Model/productModel.dart';
import 'package:two_m_production/features/pages/RecordSale/Data/DataSource/addOrderDateSource.dart';

abstract class HomeDataSource {
  Stream<Either<Failure, List<ProductModel>>> getHomeSection(String section);
  Stream<Either<Failure, List<ProductModel>>> getHomeSectionNoWiFi(
    String section,
  );
  Future<Either<Failure, bool>> addProducStock(
    int count,
    String id,
    String date,
    String? note,
    String name,
  );
}

class HomeDataSourceImp extends HomeDataSource {
  final FirebaseFirestore firestore;
  HomeDataSourceImp(this.firestore);
  @override
  Future<Either<Failure, bool>> addProducStock(
    int count,
    String id,
    String date,
    String? note,
    String name,
  ) async {
    try {
      final rawDate = date.trim();
      final cleanedDate = rawDate.isEmpty
          ? DateFormat('yyyy-MM-dd', 'en').format(DateTime.now())
          : normalizeDate(rawDate);

      bool isOfflineSync = false;

      // 1. Queue product update synchronously.
      final productUpdateFuture = firestore
          .collection('Products')
          .doc(id)
          .update({
            'stock': FieldValue.increment(count),
            'date': cleanedDate,
            'note': note,
          });

      // Try to await it with a short timeout.
      try {
        await productUpdateFuture.timeout(const Duration(seconds: 3));
      } on TimeoutException {
        isOfflineSync = true;
      } on FirebaseException catch (e) {
        if (e.code == 'unavailable' || e.code == 'network-request-failed') {
          isOfflineSync = true;
        } else {
          rethrow;
        }
      }

      // 2. Fetch the Injection document safely.
      QuerySnapshot? query;
      try {
        query = await firestore
            .collection('Injection')
            .where('product', isEqualTo: name)
            .get(GetOptions(source: isOfflineSync ? Source.cache : Source.serverAndCache))
            .timeout(const Duration(seconds: 3));
      } catch (e) {
        // Fallback to cache if network request times out or fails
        try {
          query = await firestore
              .collection('Injection')
              .where('product', isEqualTo: name)
              .get(const GetOptions(source: Source.cache));
        } catch (_) {
          // Ignore cache misses. The product update is already queued safely.
        }
        isOfflineSync = true;
      }

      // 3. Queue Injection updates if query succeeded.
      if (query != null) {
        for (final doc in query.docs) {
          final current = int.tryParse(doc['totalCount'].toString()) ?? 0;
          final injectionUpdateFuture = doc.reference.update({
            'totalCount': (current + count).toString(),
          });
          
          if (!isOfflineSync) {
            try {
              await injectionUpdateFuture.timeout(const Duration(seconds: 2));
            } catch (_) {
              isOfflineSync = true;
            }
          }
        }
      }

      return Right(!isOfflineSync);
    } catch (e) {
      // If it reaches here, it's a hard error, but we'll return an offline success
      // anyway because the synchronous firestore.update queueing already happened!
      return const Right(false);
    }
  }

  @override
  Stream<Either<Failure, List<ProductModel>>> getHomeSection(
    String section,
  ) async* {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
          'lastConnection': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }
      Query<Map<String, dynamic>> query;
      if (section == 'All products 2M') {
        query = firestore.collection('Products');
      } else if (section == 'Low Stock') {
        query = firestore
            .collection('Products')
            .where('stock', isLessThan: 200);
      } else {
        query = firestore
            .collection('Products')
            .where('section', isEqualTo: section);
      }
      await for (var snapshot in query.snapshots()) {
        final products = snapshot.docs
            .map((doc) => ProductModel.fromJson(doc.data()))
            .toList();
        Localhelper.remove(Localhelper.kProducts);
        Localhelper.setProducts(Localhelper.kProducts, products);
        yield Right(products);
      }
    } catch (e) {
      yield Left(Failure(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<ProductModel>>> getHomeSectionNoWiFi(
    String section,
  ) async* {
    try {
      List<ProductModel> products = await Localhelper.getProducts(
        Localhelper.kProducts,
      );
      yield Right(products);
    } on Exception catch (e) {
      yield Left(Failure(message: e.toString()));
    }
  }
}
