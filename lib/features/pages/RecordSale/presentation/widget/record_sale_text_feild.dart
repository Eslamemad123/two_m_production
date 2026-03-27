import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker_plus/model/contact_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:two_m_production/components/inputs/main_text_form_field.dart';
import 'package:two_m_production/core/constatnts/images.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/features/pages/RecordSale/presentation/cubit/order_cubit.dart';
import 'package:two_m_production/features/pages/addToStock/widget/date_text_form.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';
import 'package:flutter_native_contact_picker_plus/flutter_native_contact_picker_plus.dart';

// ignore: must_be_immutable
class RecordSaleTextFeild extends StatefulWidget {
  RecordSaleTextFeild({super.key, required this.cubit});
  OrderCubit cubit;

  @override
  State<RecordSaleTextFeild> createState() => _RecordSaleTextFeildState();
}

class _RecordSaleTextFeildState extends State<RecordSaleTextFeild> {
  final _contactPicker = FlutterContactPickerPlus();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.cubit.formKey,

      child: Column(
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
          DateTextForm(orderCubit: widget.cubit),
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

            ispassword: false,
            controller: widget.cubit.nameController,
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

            sufixIcon: IconButton(
              icon: const Icon(Icons.contacts, color: AppColors.primary),

              onPressed: () async {
                Contact? contact = await _contactPicker.selectPhoneNumber();

                if (contact != null &&
                    contact.selectedPhoneNumber != null &&
                    contact.fullName != null) {
                  widget.cubit.phoneController.text =
                      contact.selectedPhoneNumber!;
                  widget.cubit.nameController.text = contact.fullName!;
                }
              },
            ),
            ispassword: false,
            controller: widget.cubit.phoneController,

            prefixIcon: AppAssets.phoneSVG,
            ketboardType: TextInputType.number,
            hint: '01XXXXXXXXX',

            label: LocaleKeys.record_sale_phone_number.tr(),
          ),
          Gap(10.h),

          Padding(
            padding: EdgeInsetsDirectional.only(start: 8.0.w),
            child: Text(
              LocaleKeys.misc_price.tr(),
              style: AppFontStyles.getSize14(fontWeight: FontWeight.w600),
            ),
          ),
          Gap(10.h),
          MainTextFormField(
            // ignore: body_might_complete_normally_nullable
            validator: (value) {
              if (value == null || value.isEmpty) {
                return LocaleKeys.misc_please_enter_price.tr();
              }
            },
            ketboardType: TextInputType.number,
            ispassword: false,
            controller: widget.cubit.priceController,

            prefixIcon: AppAssets.walletSVG,
            hint: '1000',

            label: LocaleKeys.misc_price.tr(),
          ),
          SizedBox(height: 24.h),
          Gap(10.h),

          Wrap(
            spacing: 12.w,
            runSpacing: 10.h,
            children: [
              buildPaymentChip(
                title: LocaleKeys.misc_vodafone_cash.tr(),
                iconPath: AppAssets.vodafone,
                selected: widget.cubit.vodafonCash,
                onTap: (val) {
                  setState(() {
                    widget.cubit.vodafonCash = val;
                  });
                },
              ),
              buildPaymentChip(
                title: LocaleKeys.misc_indrive.tr(),
                iconPath: AppAssets.inDrive,
                selected: widget.cubit.inDrive,
                onTap: (val) {
                  setState(() {
                    widget.cubit.inDrive = val;
                  });
                },
              ),
            ],
          ),
          Gap(15),
        ],
      ),
    );
  }
}

Widget buildPaymentChip({
  required String title,
  required String iconPath,
  required bool selected,
  required ValueChanged<bool> onTap,
}) {
  return GestureDetector(
    onTap: () => onTap(!selected),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.gray100,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(
          color: selected ? AppColors.primary : Colors.transparent,
          width: 2.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(iconPath, width: 20.w, height: 20.h),
          SizedBox(width: 6.w),
          Text(
            title,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: selected ? AppColors.primary : Colors.black87,
            ),
          ),
          if (selected) ...[
            SizedBox(width: 6.w),
            Icon(Icons.check, size: 18.sp, color: AppColors.primary),
          ],
        ],
      ),
    ),
  );
}
