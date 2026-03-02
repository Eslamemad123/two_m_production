import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class OrderItemHeader extends StatelessWidget {
  const OrderItemHeader({super.key, required this.orderId, required this.date});

  final String date;
  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              '${LocaleKeys.orders_order_id.tr()}${orderId}',
              style: AppFontStyles.getSize16(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8.w),
            Container(
              width: 8.w,
              height: 8.h,
              decoration: BoxDecoration(
                color: const Color(0xFF2ECC71),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        Text(
          date,
          style: AppFontStyles.getSize12(fontColor: AppColors.textSecondary),
        ),
      ],
    );
  }
}
