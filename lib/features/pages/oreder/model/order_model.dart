class OrderModel {
  final int id;
  final String date;
  final String trackingNumber;
  final int quantity;
  final double subtotal;
  final String status; // 'PENDING' or 'DELIVERED'
  final String clientName;
  final String clientPhone;

  OrderModel({
    required this.id,
    required this.date,
    required this.trackingNumber,
    required this.quantity,
    required this.subtotal,
    required this.status,
    required this.clientName,
    required this.clientPhone,
  });
}
