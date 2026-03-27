import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/features/pages/Home/Data/Model/productModel.dart';
import 'package:two_m_production/features/pages/ProductDetails/widget/home__slider.dart';
import 'package:two_m_production/features/pages/ProductDetails/widget/product_details_image.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    // Fixed size index: 0=S, 1=M, 2=L, 3=XL
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        leading: Padding(
          padding: EdgeInsets.all(8.0.r),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => context.pop(),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.4.h,
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Center(
                child: PhotosProductDetails(
                  images: product.imagePath ?? [],
                  id: product.id,
                ),
              ),
            ),
          ),
          ProductDetailsImage(product: product),
        ],
      ),
    );
  }
}
