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
      final nameToSave = order.name.trim().isEmpty ? 'بدون اسم' : order.name.trim();
      final phoneToSave = order.Phone.trim();

      // 1. Calculate itemsCount for this order
      int currentItemsCount = 0;
      for (final qty in order.sizes.values) {
        currentItemsCount += qty;
      }

      final bool isPhoneEmpty = phoneToSave.isEmpty;

      // --- PHASE A: Pre-Transaction Queries (Gather References) ---
      
      // Get customer reference if phone is not empty
      DocumentReference? customerRef;
      if (!isPhoneEmpty) {
        final customerQuery = await firestore
            .collection('Customers')
            .where('phone', isEqualTo: phoneToSave)
            .limit(1)
            .get();
        if (customerQuery.docs.isNotEmpty) {
          customerRef = customerQuery.docs.first.reference;
        }
      }

      // Get all product references before starting transaction
      final Map<String, DocumentReference> productRefs = {};
      for (final entry in order.sizes.entries) {
        final productName = entry.key;
        final query = await firestore
            .collection('Products')
            .where('name', isEqualTo: productName)
            .limit(1)
            .get();

        if (query.docs.isEmpty) {
          throw Exception('Product not found: $productName');
        }
        productRefs[productName] = query.docs.first.reference;
      }

      // --- PHASE B: Start Transaction ---
      await firestore.runTransaction((transaction) async {
        final now = DateTime.now();
        final month = now.month.toString().padLeft(2, '0');
        final monthKey = "${now.year}-$month";

        final counterRef = firestore.collection('Metadata').doc('order_counters');

        // 1. ALL READ OPERATIONS FIRST
        final DocumentSnapshot counterSnap = await transaction.get(counterRef);
        
        DocumentSnapshot? customerSnapshot;
        if (customerRef != null) {
          customerSnapshot = await transaction.get(customerRef);
        }

        final Map<String, DocumentSnapshot> productSnapshots = {};
        for (final entry in productRefs.entries) {
          productSnapshots[entry.key] = await transaction.get(entry.value);
        }

        // 2. ALL CALCULATIONS SECOND (In memory)
        
        // Counter ID generation
        int orderNumberInMonth = 1;
        if (counterSnap.exists) {
          final counterData = counterSnap.data() as Map<String, dynamic>;
          orderNumberInMonth = (counterData[monthKey] ?? 0) + 1;
        }

        final generatedOrderId = '$month-$orderNumberInMonth';

        // Prepare sizes list for history
        final List<Map<String, dynamic>> sizesList = order.sizes.entries.map((entry) {
          return {
            'size': entry.key,
            'quantity': entry.value,
          };
        }).toList();

        // Normalize Date
        final rawDate = order.date.trim();
        String cleanedDate;
        if (rawDate.isEmpty) {
          cleanedDate = DateFormat('yyyy-MM-dd', 'en').format(DateTime.now());
        } else {
          cleanedDate = normalizeDate(rawDate);
        }

        final newOrderHistory = {
          'orderId': generatedOrderId,
          'date': cleanedDate,
          'price': order.price,
          'itemsCount': currentItemsCount,
          'sizes': sizesList,
          'vodafoneCash': order.vodafoneCash,
          'inDrive': order.inDrive,
        };

        // Customer creation or merge map
        Map<String, dynamic>? updatedCustomerData;
        Map<String, dynamic>? newCustomerData;
        DocumentReference? finalCustomerRef;

        final bool customerExists = customerRef != null && customerSnapshot != null && customerSnapshot.exists;

        if (customerExists) {
          finalCustomerRef = customerRef;
          final existingData = customerSnapshot!.data() as Map<String, dynamic>;
          final existingOrders = List<Map<String, dynamic>>.from(existingData['orders'] ?? []);
          
          existingOrders.add(newOrderHistory);

          double totalSpent = 0.0;
          int totalItems = 0;
          for (final ord in existingOrders) {
            totalSpent += (ord['price'] ?? 0.0).toDouble();
            totalItems += (ord['itemsCount'] ?? 0) as int;
          }

          updatedCustomerData = {
            'orders': existingOrders,
            'totalOrders': existingOrders.length,
            'totalItems': totalItems,
            'totalSpent': totalSpent,
          };
        } else {
          finalCustomerRef = firestore.collection('Customers').doc();
          newCustomerData = {
            'name': nameToSave,
            'phone': phoneToSave,
            'createdAt': FieldValue.serverTimestamp(),
            'totalOrders': 1,
            'totalItems': currentItemsCount,
            'totalSpent': order.price,
            'orders': [newOrderHistory],
          };
        }

        // Product stock validation and calculation
        final Map<DocumentReference, int> productStocksToUpdate = {};
        for (final entry in order.sizes.entries) {
          final productName = entry.key;
          final soldQuantity = entry.value;
          
          final productDoc = productSnapshots[productName];
          if (productDoc == null || !productDoc.exists) {
            throw Exception('Product data missing for: $productName');
          }

          final currentStock = productDoc['stock'] ?? 0;
          if (currentStock < soldQuantity) {
            throw Exception('Not enough stock for $productName');
          }

          productStocksToUpdate[productRefs[productName]!] = currentStock - soldQuantity;
        }

        // 3. ALL WRITE OPERATIONS LAST
        
        // Write counter
        if (counterSnap.exists) {
          transaction.update(counterRef, {monthKey: orderNumberInMonth});
        } else {
          transaction.set(counterRef, {monthKey: orderNumberInMonth});
        }

        // Write customer
        if (customerExists && updatedCustomerData != null) {
          transaction.update(finalCustomerRef!, updatedCustomerData);
        } else if (newCustomerData != null) {
          transaction.set(finalCustomerRef!, newCustomerData);
        }

        // Write product stocks
        productStocksToUpdate.forEach((ref, newStock) {
          transaction.update(ref, {'stock': newStock});
        });

      }).timeout(const Duration(seconds: 10));

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
