import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/constatnts/images.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/features/pages/Home/pages/homeScreen.dart';
import 'package:two_m_production/features/pages/Main/widget/add_button.dart';
import 'package:two_m_production/features/pages/Main/widget/nav_item.dart';
import 'package:two_m_production/features/pages/Main/widget/nav_item_model.dart';
import 'package:two_m_production/features/pages/Profits/pages/ProfitsScreen.dart';
import 'package:two_m_production/features/pages/oreder/pages/ordersScreen.dart';
import 'package:two_m_production/features/pages/Setting/pages/setingScreen.dart';
import 'package:two_m_production/features/pages/RecordSale/page/record_sale_sheet.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key, this.initialIndex});
  final int? initialIndex;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex ?? 0;
  }

  final List<Widget> screens = const [
    HomeScreen(),
    ProfitsScreen(),
    RecordSaleSheet(),
    OrdersScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        height: 75.h,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
              blurRadius: 10.r,
              offset: Offset(0, -3.h),
            ),
          ],
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() => currentIndex = index);
            },
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: isDark ? AppColors.gray500 : AppColors.gray400,
            items: List.generate(navItems.length, (index) {
              final bool isSelected = currentIndex == index;
              final bool isAddItem = index == 2;

              return BottomNavigationBarItem(
                label: '',
                icon: isAddItem
                    ? CenterAddButton(
                        icon: navItems[index].selectedIcon,
                        isSelected: isSelected,
                        onTap: () {
                          setState(() => currentIndex = index);
                        },
                      )
                    : NavItem(
                        selectedIcon: navItems[index].selectedIcon,
                        unselectedIcon: navItems[index].unselectedIcon,
                        label: navItems[index].label,
                        isSelected: isSelected,
                      ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

final List<NavItemModel> navItems = [
  NavItemModel(
    selectedIcon: AppAssets.homeFiledSVG,
    unselectedIcon: AppAssets.homeLineSVG,
    label: LocaleKeys.nav_bar_home.tr(),
  ),
  NavItemModel(
    selectedIcon: AppAssets.profitsFiledSVG,
    unselectedIcon: AppAssets.profitsLineSVG,
    label: LocaleKeys.nav_bar_profit.tr(),
  ),
  NavItemModel(
    selectedIcon: AppAssets.addFiledSVG,
    unselectedIcon: AppAssets.addLineSVG,
    label: LocaleKeys.common_add.tr(),
  ),
  NavItemModel(
    selectedIcon: AppAssets.categoryFiledSVG,
    unselectedIcon: AppAssets.categoryLineSVG,
    label: LocaleKeys.nav_bar_orders.tr(),
  ),
  NavItemModel(
    selectedIcon: AppAssets.settingFiledSVG,
    unselectedIcon: AppAssets.settingLineSVG,
    label: LocaleKeys.nav_bar_settings.tr(),
  ),
];
