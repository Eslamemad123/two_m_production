import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:two_m_production/core/constatnts/images.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/features/pages/oreder/presentation/widget/order_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class AnimatedContanerOrders extends StatelessWidget {
  const AnimatedContanerOrders({
    super.key,
    required bool isExpanded,
    required this.widget,
  }) : _isExpanded = isExpanded;

  final bool _isExpanded;
  final OrderCard widget;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 300),
      crossFadeState: _isExpanded
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      firstChild: const SizedBox(),
      secondChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Divider(color: Colors.grey.shade300),
          SizedBox(height: 16.h),

          /// Client Name
          Row(
            children: [
              Icon(
                Icons.person_outline,
                size: 18.sp,
                color: AppColors.textSecondary,
              ),
              SizedBox(width: 8.w),
              Text(
                "${LocaleKeys.misc_client_label.tr()}: ${widget.order.name}",
                style: AppFontStyles.getSize14(),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          /// Phone
          Row(
            children: [
              Icon(
                Icons.phone_outlined,
                size: 18.sp,
                color: AppColors.textSecondary,
              ),
              SizedBox(width: 8.w),
              Text(
                "${LocaleKeys.misc_phone_label.tr()}: ${widget.order.Phone}",
                style: AppFontStyles.getSize14(),
              ),
            ],
          ),
          Gap(10),
          Divider(color: Colors.grey.shade300),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.order.sizes.entries.map((entry) {
              return Padding(
                padding: EdgeInsets.only(bottom: 6.h),
                child: Text(
                  "${entry.key} : ${entry.value}",
                  style: AppFontStyles.getSize14(
                    fontColor: AppColors.gray700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 8.h),
          if (widget.order.vodafoneCash || widget.order.inDrive) ...[
            Row(
              children: [
                if (widget.order.vodafoneCash) ...[
                  Image.asset(AppAssets.vodafone, width: 22.w, height: 22.h),
                  SizedBox(width: 10.w),
                ],
                if (widget.order.inDrive)
                  Image.asset(AppAssets.inDrive, width: 20.w, height: 20.h),
              ],
            ),
          ],

          SizedBox(height: 4.h),

          /// Products Map
        ],
      ),
    );
  }
}
