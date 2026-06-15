import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

class MigrationHelper {
  /// Migrates all documents from the legacy 'Orders' collection to the new 'Customers' structure.
  /// This operation is safe and does not delete the old 'Orders' collection.
  static Future<void> migrateOrdersToCustomers() async {
    log('Starting migration from Orders to Customers...');
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // 1. Fetch all legacy orders
      final ordersSnapshot = await firestore.collection('Orders').get();
      if (ordersSnapshot.docs.isEmpty) {
        log('No orders found to migrate.');
        return;
      }

      log('Found ${ordersSnapshot.docs.length} orders to migrate.');

      // 2. Group orders by phone number
      // Phone number -> list of order documents
      final Map<String, List<DocumentSnapshot>> phoneGroups = {};
      final List<DocumentSnapshot> noPhoneOrders = [];

      for (var doc in ordersSnapshot.docs) {
        final data = doc.data();
        final phone = (data['number'] ?? data['Phone'] ?? '').toString().trim();

        if (phone.isEmpty) {
          noPhoneOrders.add(doc);
        } else {
          phoneGroups.putIfAbsent(phone, () => []).add(doc);
        }
      }

      final WriteBatch batch = firestore.batch();
      int operationCount = 0;

      // Helper to commit batches safely (Firestore limit is 500 operations per batch)
      Future<void> addToBatch(DocumentReference ref, Map<String, dynamic> data, {bool isSet = true}) async {
        if (isSet) {
          batch.set(ref, data);
        } else {
          batch.update(ref, data);
        }
        operationCount++;
        if (operationCount >= 450) {
          log('Committing batch...');
          await batch.commit();
          operationCount = 0;
        }
      }

      // 3. Process grouped customers (merged by phone)
      for (final entry in phoneGroups.entries) {
        final phone = entry.key;
        final orderDocs = entry.value;

        // Use the customer name from the latest order in this group
        // Sort documents by date if possible, otherwise use orderId sequence
        orderDocs.sort((a, b) {
          final dateA = (a.data() as Map<String, dynamic>)['date'] ?? '';
          final dateB = (b.data() as Map<String, dynamic>)['date'] ?? '';
          return dateA.compareTo(dateB);
        });

        final latestOrderData = orderDocs.last.data() as Map<String, dynamic>;
        final customerName = latestOrderData['name'] ?? 'بدون اسم';

        final List<Map<String, dynamic>> orderHistoryList = [];
        double totalSpent = 0.0;
        int totalItems = 0;

        for (var doc in orderDocs) {
          final oData = doc.data() as Map<String, dynamic>;
          final price = (oData['price'] ?? 0.0).toDouble();

          // Calculate sizes list and item count
          final sizesMap = Map<String, dynamic>.from(oData['sizes'] ?? {});
          int itemsCount = 0;
          final List<Map<String, dynamic>> sizesList = [];
          
          sizesMap.forEach((sizeName, qty) {
            final int quantity = (qty is num) ? qty.toInt() : 0;
            itemsCount += quantity;
            sizesList.add({
              'size': sizeName,
              'quantity': quantity,
            });
          });

          totalSpent += price;
          totalItems += itemsCount;

          orderHistoryList.add({
            'orderId': oData['orderId'] ?? doc.id,
            'date': oData['date'] ?? '',
            'price': price,
            'itemsCount': itemsCount,
            'sizes': sizesList,
            'vodafoneCash': oData['vodafoneCash'] ?? false,
            'inDrive': oData['inDrive'] ?? false,
          });
        }

        // Create new customer reference
        final customerRef = firestore.collection('Customers').doc();
        final customerData = {
          'name': customerName,
          'phone': phone,
          'createdAt': FieldValue.serverTimestamp(),
          'totalOrders': orderDocs.length,
          'totalItems': totalItems,
          'totalSpent': totalSpent,
          'orders': orderHistoryList,
        };

        await addToBatch(customerRef, customerData);
      }

      // 4. Process non-phone orders (each is its own customer document)
      for (var doc in noPhoneOrders) {
        final oData = doc.data() as Map<String, dynamic>;
        final price = (oData['price'] ?? 0.0).toDouble();
        final customerName = oData['name'] ?? 'بدون اسم';

        final sizesMap = Map<String, dynamic>.from(oData['sizes'] ?? {});
        int itemsCount = 0;
        final List<Map<String, dynamic>> sizesList = [];
        
        sizesMap.forEach((sizeName, qty) {
          final int quantity = (qty is num) ? qty.toInt() : 0;
          itemsCount += quantity;
          sizesList.add({
            'size': sizeName,
            'quantity': quantity,
          });
        });

        final List<Map<String, dynamic>> orderHistoryList = [
          {
            'orderId': oData['orderId'] ?? doc.id,
            'date': oData['date'] ?? '',
            'price': price,
            'itemsCount': itemsCount,
            'sizes': sizesList,
            'vodafoneCash': oData['vodafoneCash'] ?? false,
            'inDrive': oData['inDrive'] ?? false,
          }
        ];

        final customerRef = firestore.collection('Customers').doc();
        final customerData = {
          'name': customerName,
          'phone': '',
          'createdAt': FieldValue.serverTimestamp(),
          'totalOrders': 1,
          'totalItems': itemsCount,
          'totalSpent': price,
          'orders': orderHistoryList,
        };

        await addToBatch(customerRef, customerData);
      }

      // Commit any remaining operations in batch
      if (operationCount > 0) {
        log('Committing final batch...');
        await batch.commit();
      }

      log('Migration completed successfully!');
    } catch (e) {
      log('Migration failed with error: $e');
    }
  }
}
