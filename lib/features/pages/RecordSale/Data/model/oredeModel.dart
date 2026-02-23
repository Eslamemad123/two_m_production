class OrderModel {
  final String name;
  final double price;
  final String Phone;
  final String orderId;
  final String date;
  final Map<String, int> sizes;

  OrderModel({
    required this.name,
    required this.price,
    required this.Phone,
    required this.orderId,
    required this.date,
    required this.sizes,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      Phone: json['number'] ?? '',
      orderId: json['orderId'] ?? '',
      date: json['date'] ?? '',
      sizes: Map<String, int>.from(json['sizes'] ?? {}),
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
    };
  }
}
