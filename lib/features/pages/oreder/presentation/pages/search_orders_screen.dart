import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/features/pages/RecordSale/presentation/cubit/order_cubit.dart';
import 'package:two_m_production/features/pages/RecordSale/presentation/cubit/order_state.dart';
import 'package:two_m_production/features/pages/oreder/presentation/widget/order_card.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class SearchOrdersScreen extends StatefulWidget {
  const SearchOrdersScreen({super.key});

  @override
  State<SearchOrdersScreen> createState() => _SearchOrdersScreenState();
}

class _SearchOrdersScreenState extends State<SearchOrdersScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(BuildContext context, String query) {
    if (query.isNotEmpty) {
      context.read<OrderCubit>().searchOrders(query);
    }
  }

  void _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      final formattedDate = DateFormat('yyyy-MM-dd', 'en').format(picked);
      _searchController.text = formattedDate;
      if (context.mounted) {
        context.read<OrderCubit>().filterOrdersByDate(formattedDate);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderCubit(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(
            LocaleKeys.nav_bar_orders
                .tr(), // or create a specific translation key for Search Orders
            style: AppFontStyles.getSize18(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Builder(
          builder: (context) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (val) => _onSearchChanged(context, val),
                    onSubmitted: (val) => _onSearchChanged(context, val),
                    decoration: InputDecoration(
                      hintText: 'Search by name, phone or date...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_month),
                        onPressed: () => _pickDate(context),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.borderLight,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.borderLight,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.primary),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<OrderCubit, OrderState>(
                    builder: (context, state) {
                      if (state is OrderSearchLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is OrderSearchSuccessState) {
                        final orders = state.orders;

                        if (orders.isEmpty) {
                          return const Center(child: Text('No orders found'));
                        }

                        return ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: orders.length,
                          itemBuilder: (context, index) {
                            return OrderCard(order: orders[index]);
                          },
                        );
                      }

                      if (state is OrderErrorState) {
                        return Center(child: Text(state.error));
                      }

                      return const Center(
                        child: Text('Type to search or pick a date to filter'),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
