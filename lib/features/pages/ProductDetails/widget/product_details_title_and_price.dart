import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class ProductDetailsTitleAndPrice extends StatelessWidget {
  const ProductDetailsTitleAndPrice({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            LocaleKeys.product_details_premium_sportswear.tr(),
            style: AppFontStyles.getSize24(fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          '\$80.00',
          style: AppFontStyles.getSize24(
            fontWeight: FontWeight.bold,
            fontColor: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
