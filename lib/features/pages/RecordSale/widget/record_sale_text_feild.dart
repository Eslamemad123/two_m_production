import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:two_m_production/components/inputs/main_text_form_field.dart';
import 'package:two_m_production/core/constatnts/images.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/features/pages/addToStock/widget/date_text_form.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class RecordSaleTextFeild extends StatelessWidget {
  const RecordSaleTextFeild({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(start: 8.0.w),
          child: Text(
            LocaleKeys.add_stock_date_received.tr(),
            style: AppFontStyles.getSize14(fontWeight: FontWeight.w600),
          ),
        ),
        Gap(5.h),
        DateTextForm(),
        Gap(15.h),
        Padding(
          padding: EdgeInsetsDirectional.only(start: 8.0.w),
          child: Text(
            LocaleKeys.add_client_client_name.tr(),
            style: AppFontStyles.getSize14(fontWeight: FontWeight.w600),
          ),
        ),
        Gap(10.h),
        MainTextFormField(
          ispassword: false,
          colorFill: AppColors.gray100,
          prefixIcon: AppAssets.userFiledSVG,
          hint: LocaleKeys.add_client_client_name_hint.tr(),
          label: LocaleKeys.add_client_client_name.tr(),
        ),
        Gap(15.h),
        Padding(
          padding: EdgeInsetsDirectional.only(start: 8.0.w),
          child: Text(
            LocaleKeys.record_sale_phone_number.tr(),
            style: AppFontStyles.getSize14(fontWeight: FontWeight.w600),
          ),
        ),
        Gap(10.h),
        MainTextFormField(
          ispassword: false,
          colorFill: AppColors.gray100,
          prefixIcon: AppAssets.phoneSVG,
          hint: LocaleKeys.add_client_phone_number_hint.tr(),

          label: LocaleKeys.record_sale_phone_number.tr(),
        ),

        SizedBox(height: 24.h),
      ],
    );
  }
}
