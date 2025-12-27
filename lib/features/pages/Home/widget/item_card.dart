import 'package:flutter/material.dart';
import 'package:two_m_production/core/constatnts/images.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/features/pages/Home/widget/cart_item_price.dart';
import 'package:two_m_production/features/pages/Home/widget/low_stock_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ItemCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final int stock;
  final double price;
  final bool isLowStock;
  final String? sizeTag;

  const ItemCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.stock,
    required this.price,
    this.isLowStock = false,
    this.sizeTag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.gray800.withValues(alpha: 0.3),
            spreadRadius: 2.r,
            blurRadius: 10.r,
            offset: Offset(0, 5.h),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(12.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Stack
            CartItemPhoto(isLowStock: isLowStock),
            Gap(10.h),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppFontStyles.getSize14(fontWeight: FontWeight.w700),
            ),
            Gap(4.h),
            Text(
              subtitle,
              style: AppFontStyles.getSize12(
                fontColor: AppColors.textSecondary,
              ),
            ),
            Gap(8.h),
            cartItemPrice(stock: stock, price: price),
          ],
        ),
      ),
    );
  }
}

class CartItemPhoto extends StatelessWidget {
  const CartItemPhoto({super.key, required this.isLowStock});

  final bool isLowStock;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Product Image
          // Using Container with color/icon since we don't have actual assets
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.backgroundSoft,
              borderRadius: BorderRadius.circular(15.r),
              // image: DecorationImage(image: AssetImage(imagePath)) // Uncomment when assets exist
            ),
            child: Center(child: Image.asset(AppAssets.large2)),
          ),
          if (isLowStock) LowStockCard(),
        ],
      ),
    );
  }
}
