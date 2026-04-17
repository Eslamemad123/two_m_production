/// Model representing aggregated daily sales data
class DailySalesData {
  final String date; // "yyyy-MM-dd"
  final String dayLabel; // "Sat", "Sun", etc. or "1", "2", ... for month
  final int totalPieces;
  final double totalRevenue;
  final int orderCount;

  const DailySalesData({
    required this.date,
    required this.dayLabel,
    required this.totalPieces,
    required this.totalRevenue,
    required this.orderCount,
  });
}

class ProfitsState {}

class ProfitsInitial extends ProfitsState {}

class ProfitsLoading extends ProfitsState {}

class ProfitsLoaded extends ProfitsState {
  final List<DailySalesData> dailySales;
  final List<String> productNames;
  final String? selectedProduct;
  final bool isWeekly;
  final int totalPieces;
  final double totalRevenue;
  final int totalOrders;
  final double dailyAverage;

  ProfitsLoaded({
    required this.dailySales,
    required this.productNames,
    required this.selectedProduct,
    required this.isWeekly,
    required this.totalPieces,
    required this.totalRevenue,
    required this.totalOrders,
    required this.dailyAverage,
  });
}

class ProfitsError extends ProfitsState {
  final String message;
  ProfitsError(this.message);
}
