import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/components/inputs/main_text_form_field.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class NotesFiledAddToStock extends StatelessWidget {
  const NotesFiledAddToStock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocaleKeys.common_notes.tr(),
              style: AppFontStyles.getSize14(fontWeight: FontWeight.w600),
            ),
            Text(
              LocaleKeys.common_optional.tr(),
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12.sp),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        MainTextFormField(
          maxTextLines: 4,
          hint: LocaleKeys.home_addAnyDetails.tr(),
          ispassword: false,
          colorFill: AppColors.gray100,
          label: LocaleKeys.common_notes.tr(),
        ),
        SizedBox(height: 32.h),
      ],
    );
  }
}
