import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/features/pages/Home/Data/Model/productModel.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class ProductDetialsDescription extends StatelessWidget {
  const ProductDetialsDescription({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.product_details_description.tr(),
          style: AppFontStyles.getSize14(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6.h),
        Text(
          product.description,
          style: AppFontStyles.getSize12(fontColor: AppColors.textSecondary),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 6.h),
        Row(
          children: [
            Text(
              LocaleKeys.misc_last_update_stock.tr(),
              style: AppFontStyles.getSize14(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6.h),
            Text(
              product.date.toString().split(' ')[0],
              style: AppFontStyles.getSize12(
                fontColor: AppColors.textSecondary,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        SizedBox(height: 6.h),
        if ((product.note ?? '').trim().isNotEmpty) ...[
          Row(
            children: [
              Text(
                LocaleKeys.misc_note.tr(),
                style: AppFontStyles.getSize14(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 6.h),

              Expanded(
                child: Text(
                  product.note!,
                  style: AppFontStyles.getSize12(
                    fontColor: AppColors.textSecondary,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
