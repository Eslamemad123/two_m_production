
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/RecordSale/Data/model/oredeModel.dart';

abstract class AddOrderDataSource {
  Future<Either<Failure, bool>> addOrder(OrderModel order);
}

class AddorderDataSourceImp extends AddOrderDataSource {
  AddorderDataSourceImp(FirebaseFirestore firebaseFirestore);

  @override
Future<Either<Failure, bool>> addOrder(
  OrderModel order,
) async {
  try {
    final firestore = FirebaseFirestore.instance;

    await firestore.runTransaction((transaction) async {
      /// 1️⃣ إضافة الأوردر
      final orderRef =
          firestore.collection('Orders').doc();

      transaction.set(orderRef, order.toJson());

      /// 2️⃣ تحديث المخزون
      for (final entry in order.sizes.entries) {
        final productName = entry.key;
        final soldQuantity = entry.value;

        final query = await firestore
            .collection('Products')
            .where('name', isEqualTo: productName)
            .limit(1)
            .get();

        if (query.docs.isEmpty) {
          throw Exception(
              'Product not found: $productName');
        }

        final productDoc = query.docs.first;
        final currentStock =
            productDoc['stock'] ?? 0;

        if (currentStock < soldQuantity) {
          throw Exception(
              'Not enough stock for $productName');
        }

        final newStock =
            currentStock - soldQuantity;

        transaction.update(
          productDoc.reference,
          {'stock': newStock},
        );
      }
    });

    return const Right(true);
  } catch (e) {
    return Left(
      Failure(message: e.toString()),
    );
  }
}
}
