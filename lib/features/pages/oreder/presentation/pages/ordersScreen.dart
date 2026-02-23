import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:two_m_production/core/constatnts/images.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/features/pages/oreder/presentation/widget/order_card.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data
    final List orders = [
      
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          LocaleKeys.nav_bar_orders.tr(),
          style: AppFontStyles.getSize18(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,

        leading: const Icon(Icons.menu, color: AppColors.textPrimary),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 10.0),
            child: GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                backgroundColor: AppColors.gray300,
                radius: 21,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.background,
                  child: SvgPicture.asset(AppAssets.searshSVG),
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return OrderCard(order: orders[index]);
        },
      ),
    );
  }
}
