import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class RecordSaleTotalPrice extends StatelessWidget {
  const RecordSaleTotalPrice({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          LocaleKeys.record_sale_estimated_total.tr(),
          style: AppFontStyles.getSize14(
            fontColor: AppColors.textSecondary,
          ),
        ),
        Text(
          '\$ 12400',
          style: AppFontStyles.getSize18(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
