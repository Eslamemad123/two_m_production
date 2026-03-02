import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class OrderItemPriceAndQuantity extends StatelessWidget {
  const OrderItemPriceAndQuantity({
    super.key,
    required this.price,
    required this.sizes,
  });

  final Map<String, int> sizes;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.common_quantity.tr(),
              style: AppFontStyles.getSize12(
                fontColor: AppColors.textSecondary,
              ),
            ),
            Text(
              '${price} ${LocaleKeys.common_items.tr()}',
              style: AppFontStyles.getSize14(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              LocaleKeys.orders_subtotal.tr(),
              style: AppFontStyles.getSize12(
                fontColor: AppColors.textSecondary,
              ),
            ),
            Text(
              //'\$${widget.order.subtotal.toStringAsFixed(2)}',
              '1200',
              style: AppFontStyles.getSize18(
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
