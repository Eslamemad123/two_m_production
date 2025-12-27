import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/components/buttons/main_button.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class AddProductImage extends StatelessWidget {
  const AddProductImage({super.key, required this.inputFillColor});

  final Color inputFillColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          // Pick image logic
        },
        child: Container(
          height: 180.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: inputFillColor,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: AppColors.border,
              style: BorderStyle.solid,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.cloud_upload_outlined,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                LocaleKeys.add_product_upload_image.tr(),
                style: AppFontStyles.getSize14(
                  fontColor: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 12.r),
              // URL Input placeholder inside
              MainButton(
                buttonText: LocaleKeys.add_product_select_image.tr(),
                onPressed: () {},
                height: 35.h,
                width: 170.w,
                borderRadius: 10.r,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
