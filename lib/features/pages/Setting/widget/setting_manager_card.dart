import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:two_m_production/core/routes/routes.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/features/pages/Setting/widget/settings_tile.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class SettingManagerCard extends StatelessWidget {
  const SettingManagerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          SettingsTile(
            customIcon: const Icon(Icons.category, color: Colors.green),
            iconBackgroundColor: Colors.green.withValues(alpha: 0.1),
            title: LocaleKeys.settings_product_categories.tr(),
            onTap: () {},
          ),
          const Divider(height: 1, color: AppColors.borderLight),
          SettingsTile(
            icon: Icons.inventory_2_outlined,
            iconColor: AppColors.textPrimary,
            iconBackgroundColor: AppColors.gray100,
            title: LocaleKeys.settings_add_product.tr(),
            onTap: () {
              // import go_router first!
              // For now, assume global context or add import
              GoRouter.of(context).push(Routes.addProduct);
            },
          ),
          const Divider(height: 1, color: AppColors.borderLight),
          SettingsTile(
            customIcon: const Icon(Icons.people, color: Colors.teal),
            iconBackgroundColor: Colors.teal.withValues(alpha: 0.1),
            title: LocaleKeys.settings_staff_access.tr(),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
