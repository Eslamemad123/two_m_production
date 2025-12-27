import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/features/pages/oreder/model/order_model.dart';
import 'package:two_m_production/features/pages/oreder/widget/order_item_expanded.dart';
import 'package:two_m_production/features/pages/oreder/widget/order_item_header.dart';
import 'package:two_m_production/features/pages/oreder/widget/order_item_price_and_quantity.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class OrderCard extends StatefulWidget {
  final OrderModel order;

  const OrderCard({super.key, required this.order});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isDelivered = widget.order.status == 'DELIVERED';

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20.r),
        child: InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          borderRadius: BorderRadius.circular(20.r),
          child: Padding(
            padding: EdgeInsets.all(16.0.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Order ID + Status Dot
                OrderItemHeader(widget: widget, isDelivered: isDelivered),
                SizedBox(height: 8.h),

                // Tracking Number
                Text(
                  '${LocaleKeys.orders_tracking_number.tr()}: ${widget.order.trackingNumber}',
                  style: AppFontStyles.getSize12(
                    fontColor: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 16.h),

                // Quantity and Subtotal
                OrderItemPriceAndQuantity(widget: widget),
                SizedBox(height: 16.h),

                // Status and Details Button

                // Expanded Section: Client Details
                OrderItemExpanded(isExpanded: _isExpanded, widget: widget),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
