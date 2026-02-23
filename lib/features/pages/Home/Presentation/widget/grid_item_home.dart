import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:two_m_production/core/constatnts/images.dart';
import 'package:two_m_production/core/routes/routes.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/features/pages/Home/Presentation/cubit/homeCubit.dart';
import 'package:two_m_production/features/pages/Home/Presentation/widget/item_card.dart';
import 'package:two_m_production/features/pages/addToStock/page/add_stock_sheet.dart';

class GridItemHome extends StatelessWidget {
  const GridItemHome({super.key, required this.cubit});
  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 0.72,
      ),
      itemCount: cubit.products.length,
      itemBuilder: (context, index) {
        if (cubit.products.isEmpty) {
          return Lottie.asset(AppAssets.emptyRedJSON);
        }
        return InkWell(
          onTap: () => context.push(
            Routes.productDetails,
            extra: {'product': cubit.products[index]},
          ),
          onLongPress: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: AppColors.transparent,
              builder: (context) =>
                  AddStockSheet(product: cubit.products[index]),
            );
          },
          child: ItemCard(model: cubit.products[index]),
        );
      },
    );
  }
}
