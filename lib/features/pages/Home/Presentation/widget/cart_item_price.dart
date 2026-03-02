import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class cartItemPrice extends StatelessWidget {
  const cartItemPrice({super.key, required this.stock, required this.price});

  final int stock;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.common_stock.tr(),
              style: AppFontStyles.getSize12(
                fontColor: AppColors.textSecondary,
                fontSize: 10.sp,
              ),
            ),
            Text(
              stock.toString(),
              style: AppFontStyles.getSize18(
                fontColor: (stock == 0) ? AppColors.gray400 : AppColors.success,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Text(
          '\$$price',
          style: AppFontStyles.getSize14(
            fontWeight: FontWeight.bold,
            fontColor: (stock == 0) ? AppColors.gray400 : AppColors.black,
          ),
        ),
      ],
    );
  }
}
