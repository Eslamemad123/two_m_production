import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:two_m_production/core/constatnts/images.dart';
import 'package:two_m_production/core/routes/routes.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/features/pages/addToStock/page/add_stock_sheet.dart';
import 'package:two_m_production/features/pages/Home/widget/item_card.dart';

class GridItemHome extends StatelessWidget {
  const GridItemHome({super.key});

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
      itemCount: 4,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => context.push(Routes.productDetails),
          onLongPress: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: AppColors.transparent,
              builder: (context) => AddStockSheet(
                initialProductName: index == 0
                    ? 'Nike Air Zoom'
                    : 'Product $index',
              ),
            );
          },
          child: ItemCard(
            imagePath: AppAssets.large1, // Placeholder
            title: index == 0 ? 'Nike Air Zoom' : 'Product $index',
            subtitle: 'Sportswear',
            stock: 120 - (index * 10),
            price: 99.99 + (index * 10),
            isLowStock: index == 1,
            sizeTag: index == 0 ? 'S, M, L' : null,
          ),
        );
      },
    );
  }
}
