import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:two_m_production/core/constatnts/images.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/features/pages/RecordSale/presentation/cubit/order_cubit.dart';
import 'package:two_m_production/features/pages/RecordSale/presentation/cubit/order_state.dart';
import 'package:two_m_production/features/pages/oreder/presentation/widget/order_card.dart';
import 'package:two_m_production/features/pages/oreder/presentation/pages/search_orders_screen.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data

    return Scaffold(
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
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SearchOrdersScreen(),
                  ),
                );
              },
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
      body: BlocProvider(
        create: (context) => OrderCubit()..getOrdersPaginated(context: context),
        child: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            var cubit = context.watch<OrderCubit>();
            if (state is OrderLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (cubit.orders.isEmpty) {
              return Center(child: Text(LocaleKeys.misc_no_orders.tr()));
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    itemCount: cubit.orders.length,
                    itemBuilder: (context, index) {
                      return OrderCard(order: cubit.orders[index]);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5.h,
                    horizontal: 20.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: cubit.currentPage > 1
                            ? () => cubit.getOrdersPaginated(
                                isPrev: true,
                                context: context,
                              )
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: cubit.currentPage > 1
                              ? AppColors.primary
                              : Colors.grey,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.arrow_back_ios, size: 16.sp),
                            SizedBox(width: 5.w),
                            Text(LocaleKeys.misc_prev.tr()),
                          ],
                        ),
                      ),
                      Text(
                        '${LocaleKeys.misc_page.tr()} ${cubit.currentPage}',
                        style: AppFontStyles.getSize16(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: cubit.orders.length == 10
                            ? () => cubit.getOrdersPaginated(
                                isNext: true,
                                context: context,
                              )
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: cubit.orders.length == 10
                              ? AppColors.primary
                              : Colors.grey,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(LocaleKeys.misc_next.tr()),
                            SizedBox(width: 5.w),
                            Icon(Icons.arrow_forward_ios, size: 16.sp),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
