import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/routes/navigation.dart';
import 'package:two_m_production/core/routes/routes.dart';
import 'package:two_m_production/core/services/cache/LocalHelper.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/features/pages/Setting/Presentation/cubit/settingCubit.dart';
import 'package:two_m_production/features/pages/Setting/Presentation/widget/editProfile/setting_image_and_name.dart';

class SettingProfileCart extends StatefulWidget {
  const SettingProfileCart({super.key, required this.cubit});
  final SettingCubit cubit;
  @override
  State<SettingProfileCart> createState() => _SettingProfileCartState();
}

class _SettingProfileCartState extends State<SettingProfileCart> {
  String name = Localhelper.getString(Localhelper.kUserName) ?? 'ES';
  String path = Localhelper.getString(Localhelper.kUserImage) ?? '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF1f2536)
            : AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Row(
        children: [
          SettingImageAndName(radius: 26),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Localhelper.getString(Localhelper.kUserName) ?? '',
                  style: AppFontStyles.getSize16(fontWeight: FontWeight.bold),
                ),
                Text(
                  Localhelper.getString(Localhelper.kUserEmail) ?? '',
                  style: AppFontStyles.getSize12(
                    fontColor: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () async {
              pushTo(context, Routes.editProfile).then((value) {
                setState(() {});
              });
            },
            icon: Icon(Icons.edit, color: AppColors.primary, size: 20.sp),
          ),
        ],
      ),
    );
  }
}
