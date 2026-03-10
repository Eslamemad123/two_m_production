import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/features/pages/oreder/presentation/widget/order_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class QuantityPriseSectionCart extends StatelessWidget {
  const QuantityPriseSectionCart({
    super.key,
    required this.totalQuantity,
    required this.widget,
  });

  final int totalQuantity;
  final OrderCard widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.misc_quantity.tr(),
              style: AppFontStyles.getSize12(
                fontColor: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              "$totalQuantity ${LocaleKeys.common_items.tr()}",
              style: AppFontStyles.getSize14(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              LocaleKeys.misc_price.tr(),
              style: AppFontStyles.getSize14(
                fontColor: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              widget.order.price.truncate().toString(),
              style: AppFontStyles.getSize16(
                fontWeight: FontWeight.bold,
                fontColor: AppColors.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
