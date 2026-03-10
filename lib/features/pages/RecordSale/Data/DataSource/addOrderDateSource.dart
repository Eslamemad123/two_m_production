import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/RecordSale/Data/model/oredeModel.dart';

abstract class AddOrderDataSource {
  Future<Either<Failure, bool>> addOrder(OrderModel order);
}

class AddorderDataSourceImp extends AddOrderDataSource {
  final FirebaseFirestore firestore;

  AddorderDataSourceImp(this.firestore);

  @override
  Future<Either<Failure, bool>> addOrder(OrderModel order) async {
    try {
      final OrderModel orderToSave = order.copyWith(
        name: order.name.trim().isEmpty ? 'بدون اسم' : order.name.trim(),
      );

      await firestore
          .runTransaction((transaction) async {
            final now = DateTime.now();
            final month = now.month.toString().padLeft(2, '0');

            final startOfMonth = DateTime(now.year, now.month, 1);
            final endOfMonth = DateTime(now.year, now.month + 1, 1);

            final monthlyOrdersQuery = await firestore
                .collection('Orders')
                .where('createdAt', isGreaterThanOrEqualTo: startOfMonth)
                .where('createdAt', isLessThan: endOfMonth)
                .get();

            final orderNumberInMonth = monthlyOrdersQuery.docs.length + 1;
            final generatedOrderId = '$month-$orderNumberInMonth';

            final orderRef = firestore.collection('Orders').doc();

            final data = orderToSave
                .copyWith(orderId: generatedOrderId)
                .toJson();

            final rawDate = data['date']?.toString().trim() ?? '';

            String cleanedDate;

            if (rawDate.isEmpty) {
              cleanedDate = DateFormat(
                'yyyy-MM-dd',
                'en',
              ).format(DateTime.now());
            } else {
              cleanedDate = normalizeDate(rawDate);
            }

            data['date'] = cleanedDate;
            data['createdAt'] = FieldValue.serverTimestamp();

            transaction.set(orderRef, data);

            for (final entry in orderToSave.sizes.entries) {
              final productName = entry.key;
              final soldQuantity = entry.value;

              final query = await firestore
                  .collection('Products')
                  .where('name', isEqualTo: productName)
                  .limit(1)
                  .get();

              if (query.docs.isEmpty) {
                throw Exception('Product not found: $productName');
              }

              final productDoc = query.docs.first;
              final currentStock = productDoc['stock'] ?? 0;

              if (currentStock < soldQuantity) {
                throw Exception('Not enough stock for $productName');
              }

              final newStock = currentStock - soldQuantity;

              transaction.update(productDoc.reference, {'stock': newStock});
            }
          })
          .timeout(const Duration(seconds: 10));

      return const Right(true);
    } on TimeoutException {
      return Left(Failure(message: 'check internet'));
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable' || e.code == 'network-request-failed') {
        return Left(Failure(message: 'check internet'));
      }

      return Left(Failure(message: e.message ?? 'Firestore error'));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}

String normalizeDate(String input) {
  const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

  for (int i = 0; i < arabic.length; i++) {
    input = input.replaceAll(arabic[i], english[i]);
  }

  return input;
}
