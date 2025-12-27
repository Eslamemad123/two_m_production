import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:two_m_production/core/constatnts/images.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/features/pages/oreder/model/order_model.dart';
import 'package:two_m_production/features/pages/oreder/widget/order_card.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data
    final List<OrderModel> orders = [
      OrderModel(
        id: 1514,
        date: '13/05/2021',
        trackingNumber: 'IK987362341',
        quantity: 2,
        subtotal: 110.00,
        status: 'PENDING',
        clientName: 'Eslam Emad',
        clientPhone: '+20 123 456 7890',
      ),
      OrderModel(
        id: 1679,
        date: '13/05/2021',
        trackingNumber: 'IK3873218690',
        quantity: 3,
        subtotal: 450.00,
        status: 'PENDING',
        clientName: 'Ahmed Ali',
        clientPhone: '+20 100 000 0000',
      ),
      OrderModel(
        id: 1671,
        date: '10/05/2021',
        trackingNumber: 'IK2275681801',
        quantity: 3,
        subtotal: 400.00,
        status: 'DELIVERED',
        clientName: 'Mohamed Salah',
        clientPhone: '+20 111 222 3333',
      ),
      OrderModel(
        id: 1420,
        date: '08/05/2021',
        trackingNumber: 'IK1102938475',
        quantity: 1,
        subtotal: 85.50,
        status: 'DELIVERED',
        clientName: 'Sarah John',
        clientPhone: '+20 155 666 7777',
      ),
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
