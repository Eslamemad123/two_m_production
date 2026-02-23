import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:two_m_production/components/buttons/main_button.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:two_m_production/features/pages/Home/Data/Model/productModel.dart'
    show ProductModel;
import 'package:two_m_production/features/pages/Home/Presentation/cubit/homeCubit.dart';
import 'package:two_m_production/features/pages/Home/Presentation/cubit/homeState.dart';
import 'package:two_m_production/features/pages/RecordSale/Data/model/oredeModel.dart';
import 'package:two_m_production/features/pages/RecordSale/Data/model/sale_item_model.dart';
import 'package:two_m_production/features/pages/RecordSale/presentation/cubit/order_cubit.dart';
import 'package:two_m_production/features/pages/RecordSale/presentation/cubit/order_state.dart';
import 'package:two_m_production/features/pages/RecordSale/presentation/widget/record_sale_text_feild.dart';
import 'package:two_m_production/features/pages/addToStock/widget/conter_on_tap_add_to_stock.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class RecordSaleSheet extends StatefulWidget {
  const RecordSaleSheet({super.key});

  @override
  State<RecordSaleSheet> createState() => _RecordSaleSheetState();
}

class _RecordSaleSheetState extends State<RecordSaleSheet> {
  final List<SaleItemModel> _items = [SaleItemModel()];

  List<ProductModel> _allProducts = [];

  void _addItem() {
    if (_items.length >= _allProducts.length) return;

    final firstAvailable = _getFirstAvailableProductName();

    setState(() {
      _items.add(SaleItemModel(size: firstAvailable));
    });
  }

  String _getFirstAvailableProductName() {
    final usedNames = _items.map((e) => e.size).toSet();

    return _allProducts
        .map((e) => e.name)
        .firstWhere((name) => !usedNames.contains(name));
  }

  List<String> _getAvailableProductNames(SaleItemModel currentItem) {
    final selectedNames = _items
        .where((e) => e != currentItem)
        .map((e) => e.size)
        .toSet();

    return _allProducts
        .map((e) => e.name)
        .where((name) => !selectedNames.contains(name))
        .toList();
  }

  void _removeItem(int index) {
    if (_items.length <= 1) return;

    setState(() {
      _items[index].dispose();
      _items.removeAt(index);
    });
  }

  void _updateQty(SaleItemModel item, int change) {
    final current = int.tryParse(item.qtyController.text) ?? 10;

    final updated = (current + change * 10).clamp(0, 100000);

    setState(() {
      item.quantity = updated;
      item.qtyController.text = updated.toString();
    });
  }

  Map<String, int> _buildProductsMap() {
    final map = <String, int>{};

    for (var item in _items) {
      map.update(
        item.size,
        (value) => value + item.quantity,
        ifAbsent: () => item.quantity,
      );
    }

    return map;
  }

  @override
  void dispose() {
    for (var item in _items) {
      item.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => OrderCubit()),
        BlocProvider(
          create: (_) {
            return HomeCubit()..getHomeSection('All products 2M');
          },
        ),
      ],
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, homeState) {
          final homeCubit = context.read<HomeCubit>();
          final orderCubit = context.read<OrderCubit>();

          _allProducts = homeCubit.products;

          if (_allProducts.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            ),
            padding: EdgeInsets.fromLTRB(
              24.w,
              24.h,
              24.w,
              MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  LocaleKeys.record_sale_title.tr(),
                  style: AppFontStyles.getSize24(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12.h),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ..._items.asMap().entries.map(
                          (entry) => _buildItemRow(entry.value, entry.key),
                        ),
                        SizedBox(height: 16.h),
                        _buildAddButton(),
                        const Divider(),
                        SizedBox(height: 24.h),
                        Form(
                          key: orderCubit.formKey,
                          child: RecordSaleTextFeild(cubit: orderCubit),
                        ),
                        BlocListener<OrderCubit, OrderState>(
                          listener: (context, state) {
                            if (state is OrderSuccessState) {
                              orderCubit.isLoading = false;
                            } else if (state is OrderErrorState) {
                              orderCubit.isLoading = false;
                            } else {
                              orderCubit.isLoading = true;
                            }
                          },
                          child: MainButton(
                            isLoading: orderCubit.isLoading,
                            buttonText: LocaleKeys.record_sale_confirm_sale
                                .tr(),
                            onPressed: () {
                              if (orderCubit.formKey.currentState!.validate()) {
                                final order = OrderModel(
                                  name: orderCubit.nameController.text,
                                  price: double.parse(
                                    orderCubit.priceController.text,
                                  ),
                                  Phone: orderCubit.phoneController.text,
                                  orderId: '10',
                                  date: orderCubit.dateController.text,
                                  sizes: _buildProductsMap(),
                                );

                                orderCubit.addOrder(order, context);
                              }
                            },
                          ),
                        ),
                        Gap(10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: _addItem,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(Icons.add_circle_outline, size: 20.sp, color: AppColors.primary),
          SizedBox(width: 8.w),
          Text(
            LocaleKeys.record_sale_add_another.tr(),
            style: AppFontStyles.getSize14(
              fontColor: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemRow(SaleItemModel item, int index) {
    final availableProducts = _getAvailableProductNames(item);

    if (!availableProducts.contains(item.size) &&
        availableProducts.isNotEmpty) {
      item.size = availableProducts.first;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (index > 0) Divider(height: 30.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${LocaleKeys.common_item.tr()} ${index + 1}',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
            ),

            SizedBox(width: 16.w),

            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: AppColors.gray100,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: item.size,
                    items: availableProducts
                        .map(
                          (name) =>
                              DropdownMenuItem(value: name, child: Text(name)),
                        )
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => item.size = val);
                      }
                    },
                  ),
                ),
              ),
            ),

            if (_items.length > 1)
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: IconButton(
                  icon: Icon(Icons.close, size: 18.sp, color: AppColors.error),
                  onPressed: () => _removeItem(index),
                ),
              ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            conterOnTapAddToStock(
              context: context,
              icon: Icons.remove,
              onTap: () => _updateQty(item, -1),
              isOutlined: true,
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Container(
                height: 48.h,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderLight),
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: item.qtyController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  onChanged: (val) => item.quantity = int.tryParse(val) ?? 10,
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            conterOnTapAddToStock(
              context: context,
              icon: Icons.add,
              onTap: () => _updateQty(item, 1),
              isOutlined: false,
            ),
          ],
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
