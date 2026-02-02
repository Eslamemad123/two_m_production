import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/features/pages/Home/Data/Model/productModel.dart';
import 'package:two_m_production/features/pages/ProductDetails/widget/product_details_buttons.dart';
import 'package:two_m_production/features/pages/ProductDetails/widget/product_details_size.dart';
import 'package:two_m_production/features/pages/ProductDetails/widget/product_details_title_and_price.dart';
import 'package:two_m_production/features/pages/ProductDetails/widget/product_detials_description.dart';

class ProductDetailsImage extends StatelessWidget {
  const ProductDetailsImage({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.1),
              blurRadius: 20.r,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(24.0.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 80.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.gray300,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              ProductDetailsTitleAndPrice(product: product),
              Spacer(flex: 1),
              ProductDetailsSize(
                selectedSizeIndex: product.size ?? 1,
                stockCount: product.stock,
              ),
              Spacer(flex: 1),
              ProductDetialsDescription(product: product),
              Spacer(flex: 1),
              ProductDetailsButtons(product: product),
            ],
          ),
        ),
      ),
    );
  }
}
