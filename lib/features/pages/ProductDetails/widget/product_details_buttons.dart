import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/features/pages/Home/Data/Model/productModel.dart';
import 'package:two_m_production/features/pages/RecordSale/presentation/page/record_sale_sheet.dart';
import 'package:two_m_production/features/pages/addToStock/page/add_stock_sheet.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class ProductDetailsButtons extends StatelessWidget {
  const ProductDetailsButtons({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddStockSheet(product: product),
                ),
              );
            },
            icon: Icon(
              Icons.edit,
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ),
            label: Text(
              LocaleKeys.common_edit.tr(),
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              elevation: 0,
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          flex: 2,
          child: ElevatedButton.icon(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) {
                  return RecordSaleSheet(
                    ispathFromDetailsProduct: false,
                    nameProduct: product.name, // المنتج نفسه
                  );
                },
              );
            },
            icon: Icon(Icons.sell, color: AppColors.white),
            label: Text(
              LocaleKeys.product_details_sell_product.tr(),
              style: TextStyle(color: AppColors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              elevation: 0,
            ),
          ),
        ),
      ],
    );
  }
}
