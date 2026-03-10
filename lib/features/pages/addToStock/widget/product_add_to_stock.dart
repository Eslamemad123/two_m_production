import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/features/pages/Home/Data/Model/productModel.dart';

class productAddToStock extends StatelessWidget {
  const productAddToStock({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.gray100,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Image(
              image: product.imagePath![0].startsWith('http')
                  ? NetworkImage(product.imagePath![0])
                  : AssetImage(product.imagePath![0]) as ImageProvider,
              errorBuilder: (context, error, stackTrace) {
                return Image.network(
                  'https://assets.tracegains.net/resources/img/global/no_image.jpg',
                );
              },
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: AppFontStyles.getSize14(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.h),
                Text(
                  '${product.subName} \u2022 ${product.code}',
                  style: AppFontStyles.getSize12(
                    fontColor: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: const Color(0xFFFFEBEE),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                SizedBox(width: 4.w),
                Text(
                  '${product.stock} In Stock',
                  style: TextStyle(
                    color: const Color(0xFFE53935),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
