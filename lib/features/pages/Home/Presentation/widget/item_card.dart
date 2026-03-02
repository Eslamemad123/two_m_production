import 'package:flutter/material.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/features/pages/Home/Data/Model/productModel.dart';
import 'package:two_m_production/features/pages/Home/Presentation/widget/cart_item_photo.dart';
import 'package:two_m_production/features/pages/Home/Presentation/widget/cart_item_price.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ItemCard extends StatelessWidget {
  final ProductModel model;

  const ItemCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.gray400.withValues(alpha: 0.3),
            spreadRadius: 1.r,
            blurRadius: 5.r,
            offset: Offset(0, 0.h),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(12.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Stack
            CartItemPhoto(
              isLowStock: (model.stock == 0),
              photo: model.imagePath![0],
            ),
            Gap(10.h),
            Text(
              model.name,

              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppFontStyles.getSize14(
                fontWeight: FontWeight.w700,
                fontColor: (model.stock == 0)
                    ? AppColors.gray400
                    : AppColors.black,
              ),
            ),
            Gap(4.h),
            Text(
              model.subName ?? '',
              style: AppFontStyles.getSize12(
                fontColor: (model.stock == 0)
                    ? AppColors.gray400
                    : AppColors.textSecondary,
              ),
            ),
            Gap(8.h),
            cartItemPrice(stock: model.stock, price: model.price),
          ],
        ),
      ),
    );
  }
}
