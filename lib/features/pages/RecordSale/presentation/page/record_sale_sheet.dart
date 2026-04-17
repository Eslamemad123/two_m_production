import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:two_m_production/components/buttons/main_button.dart';
import 'package:two_m_production/core/extentions/show_dialoges.dart';
import 'package:two_m_production/core/routes/navigation.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:two_m_production/features/pages/Home/Data/Model/productModel.dart'
    show ProductModel;
import 'package:two_m_production/features/pages/Home/Presentation/cubit/homeCubit.dart';
import 'package:two_m_production/features/pages/Home/Presentation/cubit/homeState.dart';
import 'package:two_m_production/features/pages/RecordSale/Data/model/sale_item_model.dart';
import 'package:two_m_production/features/pages/RecordSale/presentation/cubit/order_cubit.dart';
import 'package:two_m_production/features/pages/RecordSale/presentation/cubit/order_state.dart';
import 'package:two_m_production/features/pages/RecordSale/presentation/widget/record_sale_text_feild.dart';
import 'package:two_m_production/features/pages/RecordSale/presentation/widget/record_sale_item_row.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class RecordSaleSheet extends StatefulWidget {
  const RecordSaleSheet({
    super.key,
    this.ispathFromDetailsProduct = true,
    this.nameProduct,
  });

  final bool? ispathFromDetailsProduct;
  final String? nameProduct;
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
    final current = int.tryParse(item.qtyController.text) ?? 0;

    final currentProduct = _allProducts.firstWhere(
      (p) => p.name == item.size,
      orElse: () => _allProducts.first,
    );

    final maxStock = currentProduct.stock;

    final updated = (current + change * 10).clamp(0, maxStock);

    setState(() {
      item.quantity = updated;
      item.qtyController.text = updated.toString();
    });
  }

  Map<String, int> _buildProductsMap() {
    final map = <String, int>{};

    for (var item in _items) {
      if (item.quantity > 0) {
        map.update(
          item.size,
          (value) => value + item.quantity,
          ifAbsent: () => item.quantity,
        );
      }
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
                        if (widget.ispathFromDetailsProduct ?? true) ...[
                          _buildAddButton(),
                        ],
                        const Divider(),
                        SizedBox(height: 24.h),
                        RecordSaleTextFeild(cubit: orderCubit),
                        BlocListener<OrderCubit, OrderState>(
                          listener: (context, state) {
                            if (state is OrderSuccessState) {
                              Pop(context);
                              if (!widget.ispathFromDetailsProduct!) {
                                Pop(context);
                                Pop(context);
                              } else {
                                // Reset state
                                setState(() {
                                  _items.clear();
                                  _items.add(SaleItemModel());
                                  orderCubit.nameController.clear();
                                  orderCubit.priceController.clear();
                                  orderCubit.dateController.clear();
                                  orderCubit.phoneController.clear();
                                  orderCubit.formKey.currentState?.reset();
                                });
                              }
                            } else if (state is OrderErrorState) {
                              Pop(context);
                            } else if (state is OrderLoadingState) {
                              showLoadingDialog(context);
                            }
                          },
                          child: MainButton(
                            isLoading: orderCubit.isLoading,
                            buttonText: LocaleKeys.record_sale_confirm_sale
                                .tr(),
                            onPressed: () {
                                orderCubit.addOrder(
                                  _buildProductsMap(),
                                  context,
                                );
                              
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
    if (!(widget.ispathFromDetailsProduct ?? true) &&
        widget.nameProduct != null) {
      item.size = widget.nameProduct!;
    }

    final availableProducts = _getAvailableProductNames(item);

    if (!availableProducts.contains(item.size) &&
        availableProducts.isNotEmpty) {
      item.size = availableProducts.first;
    }

    return RecordSaleItemRow(
      item: item,
      index: index,
      allProducts: _allProducts,
      availableProducts: availableProducts,
      ispathFromDetailsProduct: widget.ispathFromDetailsProduct ?? true,
      nameProduct: widget.nameProduct,
      onRemove: () => _removeItem(index),
      onQuantityChanged: (change) => _updateQty(item, change),
      onProductChanged: (val) {
        setState(() {
          item.size = val;
          item.quantity = 0;
          item.qtyController.text = "0";
        });
      },
      showRemoveIcon: _items.length > 1,
    );
  }
}
