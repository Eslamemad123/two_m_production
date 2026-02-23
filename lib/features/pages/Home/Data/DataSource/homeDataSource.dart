import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/Home/Data/Model/productModel.dart';

abstract class HomeDataSource {
  Stream<Either<Failure, List<ProductModel>>> getHomeSection(String section);
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
  Stream<Either<Failure, List<ProductModel>>> getHomeSection(String section) {
    try {
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

      return query.snapshots().map((snapshot) {
        final products = snapshot.docs
            .map((doc) => ProductModel.fromJson(doc.data()))
            .toList();

        return Right(products);
      });
    } catch (e) {
      return Stream.value(Left(Failure(message: e.toString())));
    }
  }
}
