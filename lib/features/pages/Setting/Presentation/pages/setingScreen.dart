import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/core/bloc/theme_manager.dart';
import 'package:two_m_production/features/pages/Setting/Presentation/cubit/settingCubit.dart';
import 'package:two_m_production/features/pages/Setting/Presentation/cubit/settingState.dart';
import 'package:two_m_production/features/pages/Setting/Presentation/widget/button_log_out.dart';
import 'package:two_m_production/features/pages/Setting/Presentation/widget/section_header.dart';
import 'package:two_m_production/features/pages/Setting/Presentation/widget/setting_header.dart';
import 'package:two_m_production/features/pages/Setting/Presentation/widget/setting_manager_card.dart';
import 'package:two_m_production/features/pages/Setting/Presentation/widget/setting_profile_cart.dart';
import 'package:two_m_production/features/pages/Setting/Presentation/widget/settings_tile.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0.r),
            child: BlocProvider(
              create: (context) => SettingCubit(),
              child: BlocBuilder<SettingCubit, SettingState>(
                builder: (context, state) {
                  var cubit = context.read<SettingCubit>();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SettingHeader(),
                      SizedBox(height: 24.h),
                      SettingProfileCart(cubit: cubit),
                      SizedBox(height: 32.h),

                      SectionHeader(
                        title: LocaleKeys.settings_app_preferences.tr(),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Column(
                          children: [
                            SettingsTile(
                              icon: Icons.nightlight_round,
                              iconColor: Colors.blue,
                              iconBackgroundColor: Colors.blue.withValues(
                                alpha: 0.1,
                              ),
                              title: LocaleKeys.settings_dark_mode.tr(),
                              trailing: Transform.scale(
                                scale: 0.8,
                                child: ValueListenableBuilder<ThemeMode>(
                                  valueListenable: ThemeManager.themeMode,
                                  builder: (context, mode, _) {
                                    return Switch(
                                      value: mode == ThemeMode.dark,
                                      activeColor: AppColors.primary,
                                      onChanged: (val) {
                                        ThemeManager.toggleTheme();
                                      },
                                    );
                                  },
                                ),
                              ),
                              onTap: () {
                                ThemeManager.toggleTheme();
                              },
                            ),
                            const Divider(
                              height: 1,
                              color: AppColors.borderLight,
                            ),
                            SettingsTile(
                              icon: Icons.language,
                              iconColor: Colors.purple,
                              iconBackgroundColor: Colors.purple.withValues(
                                alpha: 0.1,
                              ),
                              title: LocaleKeys.settings_language.tr(),
                              trailing: Row(
                                children: [
                                  Text(
                                    context.locale.languageCode == 'en'
                                        ? 'English'
                                        : 'العربية',
                                    style: AppFontStyles.getSize12(
                                      fontColor: AppColors.textSecondary,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 14.sp,
                                    color: AppColors.textSecondary,
                                  ),
                                ],
                              ),
                              onTap: () {
                                _showLanguageDialog(context);
                              },
                            ),
                            const Divider(
                              height: 1,
                              color: AppColors.borderLight,
                            ),
                            SettingsTile(
                              icon: Icons.notifications_none,
                              iconColor: Colors.orange,
                              iconBackgroundColor: Colors.orange.withValues(
                                alpha: 0.1,
                              ),
                              title: LocaleKeys.settings_notifications.tr(),
                              trailing: Transform.scale(
                                scale: 0.8,
                                child: Switch(
                                  value: _notificationsEnabled,
                                  activeColor: AppColors.primary,
                                  onChanged: (val) {},
                                ),
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),

                      SectionHeader(title: LocaleKeys.settings_management.tr()),
                      SettingManagerCard(),
                      SizedBox(height: 24.h),

                      ButtonLogOut(),
                      SizedBox(height: 16.h),
                      Center(
                        child: Text(
                          'v 1.1.0',
                          style: AppFontStyles.getSize14(
                            fontColor: AppColors.textSecondary,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          title: Text(
            LocaleKeys.settings_language
                .tr(), // Reusing Language key or generic Select Language title if key existed
            style: AppFontStyles.getSize18(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: Text(
                  'English',
                  style: AppFontStyles.getSize16(
                    fontColor: isDark ? Colors.white : Colors.black,
                  ),
                ),
                value: 'en',
                groupValue: context.locale.languageCode,
                activeColor: AppColors.primary,
                onChanged: (val) {
                  if (val != null) {
                    context.setLocale(const Locale('en'));
                    Navigator.pop(context);
                  }
                },
              ),
              RadioListTile<String>(
                title: Text(
                  'العربية',
                  style: AppFontStyles.getSize16(
                    fontColor: isDark ? Colors.white : Colors.black,
                  ),
                ),
                value: 'ar',
                groupValue: context.locale.languageCode,
                activeColor: AppColors.primary,
                onChanged: (val) {
                  if (val != null) {
                    context.setLocale(const Locale('ar'));
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
