import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';
import 'package:two_m_production/features/pages/RecordSale/Data/model/oredeModel.dart';
import 'package:two_m_production/features/pages/oreder/presentation/widget/animated_contaner_orders.dart';
import 'package:two_m_production/features/pages/oreder/presentation/widget/quantity_prise_section_cart.dart';

class OrderCard extends StatefulWidget {
  final OrderModel order;

  const OrderCard({super.key, required this.order});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool _isExpanded = false;

  int get totalQuantity =>
      widget.order.sizes.values.fold(0, (sum, item) => sum + item);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${LocaleKeys.misc_order.tr()} #${widget.order.orderId}",
                      style: AppFontStyles.getSize16(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.order.date,
                      style: AppFontStyles.getSize12(
                        fontColor: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                /// Quantity + Subtotal
                QuantityPriseSectionCart(
                  totalQuantity: totalQuantity,
                  widget: widget,
                ),

                /// Expanded Section
                AnimatedContanerOrders(isExpanded: _isExpanded, widget: widget),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
