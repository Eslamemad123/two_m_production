import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/features/pages/oreder/presentation/widget/order_card.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class OrderItemExpanded extends StatelessWidget {
  const OrderItemExpanded({
    super.key,
    required bool isExpanded,
    required this.widget,
  }) : _isExpanded = isExpanded;

  final bool _isExpanded;
  final OrderCard widget;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: _isExpanded
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                const Divider(color: AppColors.borderLight),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: 18.sp,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      '${LocaleKeys.orders_client.tr()}: ',
                      style: AppFontStyles.getSize14(
                        fontColor: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      widget.order.clientName,
                      style: AppFontStyles.getSize14(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(
                      Icons.phone_outlined,
                      size: 18.sp,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      '${LocaleKeys.orders_phone.tr()}: ',
                      style: AppFontStyles.getSize14(
                        fontColor: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      widget.order.clientPhone,
                      style: AppFontStyles.getSize14(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}
