import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/features/pages/Home/Data/Model/productModel.dart';
import 'package:two_m_production/features/pages/RecordSale/Data/model/sale_item_model.dart';
import 'package:two_m_production/features/pages/addToStock/widget/conter_on_tap_add_to_stock.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class RecordSaleItemRow extends StatelessWidget {
  final SaleItemModel item;
  final int index;
  final List<ProductModel> allProducts;
  final List<String> availableProducts;
  final bool ispathFromDetailsProduct;
  final String? nameProduct;
  final VoidCallback onRemove;
  final void Function(int) onQuantityChanged;
  final void Function(String) onProductChanged;
  final bool showRemoveIcon;

  const RecordSaleItemRow({
    super.key,
    required this.item,
    required this.index,
    required this.allProducts,
    required this.availableProducts,
    required this.ispathFromDetailsProduct,
    this.nameProduct,
    required this.onRemove,
    required this.onQuantityChanged,
    required this.onProductChanged,
    required this.showRemoveIcon,
  });

  @override
  Widget build(BuildContext context) {
    if (!ispathFromDetailsProduct && nameProduct != null) {
      item.size = nameProduct!;
    }

    if (!availableProducts.contains(item.size) &&
        availableProducts.isNotEmpty) {
      item.size = availableProducts.first;
    }

    final currentProduct = allProducts.firstWhere(
      (p) => p.name == item.size,
      orElse: () => allProducts.first,
    );

    final availableStock = currentProduct.stock;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (index > 0) Divider(height: 30.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${LocaleKeys.common_item.tr()} ${index + 1}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '${LocaleKeys.misc_available.tr()}: $availableStock',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Color(0xFF1E1E2C) // لون دارك
                      : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade700),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    dropdownColor:
                        Theme.of(context).brightness == Brightness.dark
                        ? Color(0xFF2A2A3D) // لون القائمة نفسها
                        : Colors.white,
                    value: ispathFromDetailsProduct ? item.size : nameProduct,
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                    iconEnabledColor:
                        Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    items: ispathFromDetailsProduct
                        ? availableProducts
                              .map(
                                (name) => DropdownMenuItem(
                                  value: name,
                                  child: Text(
                                    name,
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              )
                              .toList()
                        : [
                            DropdownMenuItem(
                              value: nameProduct,
                              child: Text(
                                nameProduct!,
                                style: TextStyle(
                                  color:
                                      Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ],
                    onChanged: ispathFromDetailsProduct
                        ? (val) {
                            if (val != null) {
                              onProductChanged(val);
                            }
                          }
                        : null,
                  ),
                ),
              ),
            ),
            if (showRemoveIcon)
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: IconButton(
                  icon: Icon(Icons.close, size: 18.sp, color: AppColors.error),
                  onPressed: onRemove,
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
              onTap: () => onQuantityChanged(-1),
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
                  onChanged: (val) {
                    final maxStock = availableStock;
                    int entered = int.tryParse(val) ?? 0;

                    if (entered > maxStock) {
                      entered = maxStock;
                    }

                    if (entered < 0) entered = 0;

                    item.quantity = entered;
                    item.qtyController.text = entered.toString();
                  },
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            conterOnTapAddToStock(
              context: context,
              icon: Icons.add,
              onTap: () {
                if (item.quantity >= availableStock) return;
                onQuantityChanged(1);
              },
              isOutlined: false,
            ),
          ],
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
