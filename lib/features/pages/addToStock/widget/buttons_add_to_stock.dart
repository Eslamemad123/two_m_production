import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/features/pages/Home/Presentation/cubit/homeCubit.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class ButtonsAddToStock extends StatelessWidget {
  ButtonsAddToStock({
    super.key,
    required this.cubit,
    required this.idProduct,
    required this.name,
  });
  final HomeCubit cubit;
  final String idProduct;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              cubit.addProductStock(context, idProduct, name);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53935),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.add_stock_title.tr(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(Icons.check, color: Colors.white, size: 20.sp),
              ],
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Center(
          child: Container(
            width: double.infinity,
            height: 55,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.black, width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                LocaleKeys.common_cancel.tr(),
                style: const TextStyle(color: AppColors.textSecondary),
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
      ],
    );
  }
}
