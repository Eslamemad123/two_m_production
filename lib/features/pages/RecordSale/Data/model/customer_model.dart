import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerModel {
  final String id;
  final String name;
  final String phone;
  final int totalOrders;
  final int totalItems;
  final double totalSpent;
  final DateTime createdAt;
  final List<OrderHistoryModel> orders;

  CustomerModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.totalOrders,
    required this.totalItems,
    required this.totalSpent,
    required this.createdAt,
    required this.orders,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json, {String? docId}) {
    DateTime parsedDate;
    final createdVal = json['createdAt'];
    if (createdVal is Timestamp) {
      parsedDate = createdVal.toDate();
    } else if (createdVal is String) {
      parsedDate = DateTime.tryParse(createdVal) ?? DateTime.now();
    } else {
      parsedDate = DateTime.now();
    }

    final ordersList = json['orders'] as List? ?? [];
    final parsedOrders = ordersList
        .map((e) => OrderHistoryModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    return CustomerModel(
      id: docId ?? json['id'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      totalOrders: json['totalOrders'] ?? 0,
      totalItems: json['totalItems'] ?? 0,
      totalSpent: (json['totalSpent'] ?? 0).toDouble(),
      createdAt: parsedDate,
      orders: parsedOrders,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'totalOrders': totalOrders,
      'totalItems': totalItems,
      'totalSpent': totalSpent,
      'createdAt': Timestamp.fromDate(createdAt),
      'orders': orders.map((e) => e.toJson()).toList(),
    };
  }

  CustomerModel copyWith({
    String? id,
    String? name,
    String? phone,
    int? totalOrders,
    int? totalItems,
    double? totalSpent,
    DateTime? createdAt,
    List<OrderHistoryModel>? orders,
  }) {
    return CustomerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      totalOrders: totalOrders ?? this.totalOrders,
      totalItems: totalItems ?? this.totalItems,
      totalSpent: totalSpent ?? this.totalSpent,
      createdAt: createdAt ?? this.createdAt,
      orders: orders ?? this.orders,
    );
  }
}

class OrderHistoryModel {
  final String orderId;
  final String date;
  final double price;
  final int itemsCount;
  final List<OrderSizeModel> sizes;
  final bool vodafoneCash;
  final bool inDrive;

  OrderHistoryModel({
    required this.orderId,
    required this.date,
    required this.price,
    required this.itemsCount,
    required this.sizes,
    this.vodafoneCash = false,
    this.inDrive = false,
  });

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    final sizesList = json['sizes'] as List? ?? [];
    final parsedSizes = sizesList
        .map((e) => OrderSizeModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    return OrderHistoryModel(
      orderId: json['orderId'] ?? '',
      date: json['date'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      itemsCount: json['itemsCount'] ?? 0,
      sizes: parsedSizes,
      vodafoneCash: json['vodafoneCash'] ?? false,
      inDrive: json['inDrive'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'date': date,
      'price': price,
      'itemsCount': itemsCount,
      'sizes': sizes.map((e) => e.toJson()).toList(),
      'vodafoneCash': vodafoneCash,
      'inDrive': inDrive,
    };
  }

  Map<String, int> get sizesMap => {
        for (var item in sizes) item.size: item.quantity,
      };
}

class OrderSizeModel {
  final String size;
  final int quantity;

  OrderSizeModel({
    required this.size,
    required this.quantity,
  });

  factory OrderSizeModel.fromJson(Map<String, dynamic> json) {
    return OrderSizeModel(
      size: json['size'] ?? '',
      quantity: json['quantity'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'size': size,
      'quantity': quantity,
    };
  }
}
