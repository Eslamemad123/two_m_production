import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/features/pages/Home/Data/Model/productModel.dart';

class ProductDetailsTitleAndPrice extends StatelessWidget {
  const ProductDetailsTitleAndPrice({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: AppFontStyles.getSize24(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                product.subName ?? '',
                style: AppFontStyles.getSize12(
                  fontColor: AppColors.textSecondary,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),

        Text(
          ' ${product.price.toString()} \$',
          style: AppFontStyles.getSize18(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            fontColor: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
