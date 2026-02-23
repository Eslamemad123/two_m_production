import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:two_m_production/components/inputs/main_text_form_field.dart';
import 'package:two_m_production/core/constatnts/images.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/features/pages/RecordSale/presentation/cubit/order_cubit.dart';
import 'package:two_m_production/features/pages/addToStock/widget/date_text_form.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

// ignore: must_be_immutable
class RecordSaleTextFeild extends StatelessWidget {
  RecordSaleTextFeild({super.key, required this.cubit});
  OrderCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(start: 8.0.w),
          child: Text(
            LocaleKeys.add_stock_date_received.tr(),
            style: AppFontStyles.getSize14(fontWeight: FontWeight.w600),
          ),
        ),
        Gap(5.h),
        DateTextForm(orderCubit: cubit),
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
          textInputNext: TextInputAction.next,
          validator: (value) {
            if (value == null) {
              return 'Please Enter Name Clinet';
            }
          },
          ispassword: false,
          controller: cubit.nameController,
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
          textInputNext: TextInputAction.next,

          ispassword: false,
          controller: cubit.phoneController,

          colorFill: AppColors.gray100,
          prefixIcon: AppAssets.phoneSVG,
          hint: LocaleKeys.add_client_phone_number_hint.tr(),

          label: LocaleKeys.record_sale_phone_number.tr(),
        ),
        Gap(10.h),

        Padding(
          padding: EdgeInsetsDirectional.only(start: 8.0.w),
          child: Text(
            'Price',
            style: AppFontStyles.getSize14(fontWeight: FontWeight.w600),
          ),
        ),
        Gap(10.h),
        MainTextFormField(
          validator: (value) {
            if (value == null) {
              return 'Please Enter Price';
            }
          },
          ketboardType: TextInputType.number,
          ispassword: false,
          controller: cubit.priceController,

          colorFill: AppColors.gray100,
          prefixIcon: AppAssets.walletSVG,

          label: 'Price',
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
