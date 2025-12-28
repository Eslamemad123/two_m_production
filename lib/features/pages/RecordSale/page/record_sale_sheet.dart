import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/components/buttons/main_button.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:two_m_production/features/pages/RecordSale/model/sale_item_model.dart';
import 'package:two_m_production/features/pages/RecordSale/widget/record_sale_text_feild.dart';
import 'package:two_m_production/features/pages/RecordSale/widget/record_sale_total_price.dart';
import 'package:two_m_production/features/pages/addToStock/widget/conter_on_tap_add_to_stock.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class RecordSaleSheet extends StatefulWidget {
  const RecordSaleSheet({super.key});

  @override
  State<RecordSaleSheet> createState() => _RecordSaleSheetState();
}

class _RecordSaleSheetState extends State<RecordSaleSheet> {
  // Model for dynamic rows
  final List<SaleItemModel> _items = [SaleItemModel()];
//dfg
  void _addItem() {
    setState(() {
      _items.add(SaleItemModel());
    });
  }

  void _removeItem(int index) {
    if (_items.length > 1) {
      setState(() {
        _items[index].dispose();
        _items.removeAt(index);
      });
    }
  }

  void _updateQty(SaleItemModel item, int change) {
    setState(() {
      int currentQty = int.tryParse(item.qtyController.text) ?? 0;
      int newQty = currentQty + change;
      if (newQty < 1) newQty = 1;
      item.quantity = newQty;
      item.qtyController.text = newQty.toString();
    });
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Calculated total (mock price per item logic or manual)
    // For now purely visual as requested

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.fromLTRB(
        24.w,
        24.h,
        24.w,
        MediaQuery.of(context).viewInsets.bottom + 24.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.record_sale_title.tr(),
                style: AppFontStyles.getSize24(fontWeight: FontWeight.bold),
              ),
              IconButton(icon: const Icon(Icons.close), onPressed: () {}),
            ],
          ),
          SizedBox(height: 12.h),

          // Scrollable Content
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Dynamic Items List
                  ..._items.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    return _buildItemRow(context, item, index, isDark);
                  }).toList(),

                  // Add Another Button
                  SizedBox(height: 16.h),
                  GestureDetector(
                    onTap: _addItem,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.add_circle_outline,
                          color: AppColors.primary,
                          size: 20.sp,
                        ),
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
                  ),
                  SizedBox(height: 24.h),
                  RecordSaleTextFeild(),

                  // Total
                  const Divider(),
                  SizedBox(height: 12.h),
                  RecordSaleTotalPrice(),
                  SizedBox(height: 24.h),

                  // Confirm Button
                  MainButton(
                    buttonText: LocaleKeys.record_sale_confirm_sale.tr(),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemRow(
    BuildContext context,
    SaleItemModel item,
    int index,
    bool isDark,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (index > 0) Divider(height: 30.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${LocaleKeys.common_item.tr()} ${index + 1}',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12.sp),
            ),
            if (_items.length > 1)
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(Icons.close, color: AppColors.error, size: 18.sp),
                onPressed: () => _removeItem(index),
              ),
          ],
        ),
        SizedBox(height: 8.h),

        _buildLabel(LocaleKeys.record_sale_select_size.tr()),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkSurfaceAlt : AppColors.gray100,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: item.size,
                    dropdownColor: isDark
                        ? AppColors.darkSurfaceAlt
                        : Colors.white,
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 14.sp,
                    ),
                    items: ['S', 'M', 'L', 'XL']
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                    onChanged: (val) {
                      setState(() => item.size = val!);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),

        _buildLabel(LocaleKeys.common_quantity.tr()),
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
                  color: isDark ? AppColors.darkSurfaceAlt : Colors.white,
                ),
                child: TextField(
                  controller: item.qtyController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onChanged: (val) {
                    item.quantity = int.tryParse(val) ?? 1;
                  },
                  style: AppFontStyles.getSize18(
                    fontWeight: FontWeight.bold,
                    fontColor: isDark ? Colors.white : AppColors.textPrimary,
                  ),
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

  Widget _buildLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0.h),
      child: Text(
        label,
        style: AppFontStyles.getSize12(
          fontColor: AppColors.textSecondary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
