class OrderModel {
  final String name;
  final double price;
  final String Phone;
  final String orderId;
  final String date;
  final Map<String, int> sizes;

  final bool vodafoneCash;
  final bool inDrive;

  OrderModel({
    required this.name,
    required this.price,
    required this.Phone,
    required this.orderId,
    required this.date,
    required this.sizes,
    this.vodafoneCash = false,
    this.inDrive = false,
  });

  OrderModel copyWith({
    String? name,
    double? price,
    String? Phone,
    String? orderId,
    String? date,
    Map<String, int>? sizes,
    bool? vodafoneCash,
    bool? inDrive,
  }) {
    return OrderModel(
      name: name ?? this.name,
      price: price ?? this.price,
      Phone: Phone ?? this.Phone,
      orderId: orderId ?? this.orderId,
      date: date ?? this.date,
      sizes: sizes ?? this.sizes,
      vodafoneCash: vodafoneCash ?? this.vodafoneCash,
      inDrive: inDrive ?? this.inDrive,
    );
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      Phone: json['number'] ?? '',
      orderId: json['orderId'] ?? '',
      date: json['date'] ?? '',
      sizes: Map<String, int>.from(json['sizes'] ?? {}),
      vodafoneCash: json['vodafoneCash'] ?? false,
      inDrive: json['inDrive'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'number': Phone,
      'orderId': orderId,
      'date': date,
      'sizes': sizes,
      'vodafoneCash': vodafoneCash,
      'inDrive': inDrive,
    };
  }
}
