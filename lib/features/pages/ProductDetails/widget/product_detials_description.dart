import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class ProductDetialsDescription extends StatelessWidget {
  const ProductDetialsDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.product_details_description.tr(),
          style: AppFontStyles.getSize16(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.h),
        Text(
          LocaleKeys.product_details_sportswear_desc.tr(),
          style: AppFontStyles.getSize12(fontColor: AppColors.textSecondary),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
