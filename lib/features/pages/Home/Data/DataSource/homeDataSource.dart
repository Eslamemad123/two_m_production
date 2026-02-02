import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/Home/Data/Model/productModel.dart';

abstract class HomeDataSource {
  Future<Either<Failure, List<ProductModel>>> getHomeSection(String section);
  Future<Either<Failure, bool>> addProducStock(
    int count,
    String id,
    String date,
    String? note,
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
  ) async {
    try {
      await firestore.collection('Products').doc(id).update({
        'stock': FieldValue.increment(count),
        'date': (date.isEmpty)
            ? DateFormat('yyyy-MM-dd').format(DateTime.now())
            : date,
        'note': note,
      });
      return const Right(true);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getHomeSection(
    String section,
  ) async {
    /*final docRef = FirebaseFirestore.instance.collection('products').doc();
    ProductModel pro = ProductModel(
      id: docRef.id,
      description: 'Covers 2m MG in Sock',
      name: 'X Larg ',
      price: 350,
      section: 'All',
      size: 1,
      stock: 80,
      code: '2003lx',
      date: DateTime.now(),
      imagePath: AppAssets.large2,
      injectionMolding: '1',
      state: 'inStock',
      subName: '2M Cover',
    );
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    final CollectionReference _patientCollection = _firestore.collection(
      'Products',
    );
    _patientCollection.doc(pro.id).set(pro.toJson());
*/
    log(section);
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot;
      if (section == 'All products 2M') {
        querySnapshot = await firestore.collection('Products').get();
      } else if (section == 'Low Stock') {
        querySnapshot = await firestore
            .collection('Products')
            .where('stock', isLessThan: 200)
            .get();
      } else {
        querySnapshot = await firestore
            .collection('Products')
            .where('section', isEqualTo: section)
            .get();
      }

      final products = querySnapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data()))
          .toList();

      return Right(products);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
