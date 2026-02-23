import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/features/pages/oreder/presentation/widget/order_card.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class OrderItemHeader extends StatelessWidget {
  const OrderItemHeader({
    super.key,
    required this.widget,
    required this.isDelivered,
  });

  final OrderCard widget;
  final bool isDelivered;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              '${LocaleKeys.orders_order_id.tr()}${widget.order.id}',
              style: AppFontStyles.getSize16(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              width: 8.w,
              height: 8.h,
              decoration: BoxDecoration(
                color: isDelivered
                    ? const Color(0xFF2ECC71)
                    : const Color(0xFFFFC107),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        Text(
          widget.order.date,
          style: AppFontStyles.getSize12(
            fontColor: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
