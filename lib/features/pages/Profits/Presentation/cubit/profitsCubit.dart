import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';
import 'package:two_m_production/core/GetIt/gi.dart';
import 'package:two_m_production/features/pages/Profits/Domain/UseCase/getProductNamesUseCase.dart';
import 'package:two_m_production/features/pages/Profits/Domain/UseCase/getSalesDataUseCase.dart';
import 'package:two_m_production/features/pages/Profits/Presentation/cubit/profitsState.dart';
import 'package:two_m_production/features/pages/RecordSale/Data/model/oredeModel.dart';

class ProfitsCubit extends Cubit<ProfitsState> {
  ProfitsCubit() : super(ProfitsInitial());

  final GetSalesDataUseCase _getSalesData = gi<GetSalesDataUseCase>();
  final GetProductNamesUseCase _getProductNames = gi<GetProductNamesUseCase>();

  bool _isWeekly = true;
  String? _selectedProduct;
  List<OrderModel> _allOrders = [];
  List<String> _productNames = [];

  bool get isWeekly => _isWeekly;
  String? get selectedProduct => _selectedProduct;

  /// Load initial data
  Future<void> loadData() async {
    emit(ProfitsLoading());

    // Fetch product names
    final namesResult = await _getProductNames.call();
    namesResult.fold(
      (failure) => {},
      (names) => _productNames = names,
    );

    // Fetch sales data
    await _fetchSalesData();
  }

  /// Toggle between weekly and monthly view
  Future<void> togglePeriod(bool isWeekly) async {
    _isWeekly = isWeekly;
    emit(ProfitsLoading());
    await _fetchSalesData();
  }

  /// Filter by a specific product (null = all products)
  void filterByProduct(String? productName) {
    _selectedProduct = productName;
    _processAndEmit();
  }

  /// Fetch orders for the current period
  Future<void> _fetchSalesData() async {
    final now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd', 'en');

    String startDate;
    String endDate = formatter.format(now);

    if (_isWeekly) {
      // Current week: Saturday to Friday (Arabic week)
      final int weekday = now.weekday; // Mon=1 ... Sun=7
      // Saturday = 6 in Dart's weekday
      final int daysSinceSaturday = (weekday % 7 + 1) % 7;
      // If today is Saturday (6), daysSinceSaturday = 0
      // If today is Sunday (7), daysSinceSaturday = 1
      // If today is Monday (1), daysSinceSaturday = 2
      // etc.
      final saturday = now.subtract(Duration(days: daysSinceSaturday));
      startDate = formatter.format(saturday);
    } else {
      // Current month
      final firstDay = DateTime(now.year, now.month, 1);
      startDate = formatter.format(firstDay);
    }

    final result = await _getSalesData.call(startDate, endDate);
    result.fold(
      (failure) => emit(ProfitsError(failure.message)),
      (orders) {
        _allOrders = orders;
        _processAndEmit();
      },
    );
  }

  /// Process orders and emit loaded state
  void _processAndEmit() {
    final now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd', 'en');

    // Generate date range
    List<String> dateRange = [];
    List<String> dayLabels = [];

    if (_isWeekly) {
      final int weekday = now.weekday;
      final int daysSinceSaturday = (weekday % 7 + 1) % 7;
      final saturday = now.subtract(Duration(days: daysSinceSaturday));

      final List<String> weekDayNames = [
        LocaleKeys.common_sat.tr(),
        LocaleKeys.common_sun.tr(),
        LocaleKeys.common_mon.tr(),
        LocaleKeys.common_tue.tr(),
        LocaleKeys.common_wed.tr(),
        LocaleKeys.common_thu.tr(),
        LocaleKeys.common_fri.tr(),
      ];

      for (int i = 0; i < 7; i++) {
        final day = saturday.add(Duration(days: i));
        dateRange.add(formatter.format(day));
        dayLabels.add(weekDayNames[i]);
      }
    } else {
      final firstDay = DateTime(now.year, now.month, 1);
      final lastDay = DateTime(now.year, now.month + 1, 0);
      final daysInMonth = lastDay.day;

      for (int i = 0; i < daysInMonth; i++) {
        final day = firstDay.add(Duration(days: i));
        dateRange.add(formatter.format(day));
        dayLabels.add('${i + 1}');
      }
    }

    // Aggregate data per day
    Map<String, int> piecesPerDay = {};
    Map<String, double> revenuePerDay = {};
    Map<String, int> ordersPerDay = {};

    for (var date in dateRange) {
      piecesPerDay[date] = 0;
      revenuePerDay[date] = 0;
      ordersPerDay[date] = 0;
    }

    for (var order in _allOrders) {
      if (!dateRange.contains(order.date)) continue;

      int pieces = 0;
      if (_selectedProduct != null) {
        // Filter by specific product/size
        pieces = order.sizes[_selectedProduct] ?? 0;
      } else {
        // Sum all sizes
        pieces = order.sizes.values.fold(0, (sum, qty) => sum + qty);
      }

      piecesPerDay[order.date] = (piecesPerDay[order.date] ?? 0) + pieces;
      revenuePerDay[order.date] =
          (revenuePerDay[order.date] ?? 0) + order.price;
      ordersPerDay[order.date] = (ordersPerDay[order.date] ?? 0) + 1;
    }

    // Build daily sales list
    List<DailySalesData> dailySales = [];
    for (int i = 0; i < dateRange.length; i++) {
      final date = dateRange[i];
      dailySales.add(DailySalesData(
        date: date,
        dayLabel: dayLabels[i],
        totalPieces: piecesPerDay[date] ?? 0,
        totalRevenue: revenuePerDay[date] ?? 0,
        orderCount: ordersPerDay[date] ?? 0,
      ));
    }

    // Calculate totals
    final totalPieces = dailySales.fold<int>(0, (s, d) => s + d.totalPieces);
    final totalRevenue =
        dailySales.fold<double>(0, (s, d) => s + d.totalRevenue);
    final totalOrders = dailySales.fold<int>(0, (s, d) => s + d.orderCount);
    final daysWithData = dailySales.where((d) => d.totalPieces > 0).length;
    final dailyAverage =
        daysWithData > 0 ? totalPieces / daysWithData : 0.0;

    emit(ProfitsLoaded(
      dailySales: dailySales,
      productNames: _productNames,
      selectedProduct: _selectedProduct,
      isWeekly: _isWeekly,
      totalPieces: totalPieces,
      totalRevenue: totalRevenue,
      totalOrders: totalOrders,
      dailyAverage: dailyAverage,
    ));
  }
}
