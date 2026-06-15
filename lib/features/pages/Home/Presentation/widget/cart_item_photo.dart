import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/features/pages/Home/Presentation/widget/low_stock_card.dart';

class CartItemPhoto extends StatelessWidget {
  const CartItemPhoto({
    super.key,

    required this.isLowStock,
    required this.photo,
    required this.id
  });

  final bool isLowStock;
  final String photo;
  final String id;
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
            child: Center(
  child: photo.startsWith('http')
      ? Image.network(
          photo,
          opacity: isLowStock
              ? const AlwaysStoppedAnimation(0.35)
              : const AlwaysStoppedAnimation(1),
          errorBuilder: (context, error, stackTrace) {
            return Image.network(
              'https://assets.tracegains.net/resources/img/global/no_image.jpg',
              opacity: isLowStock
                  ? const AlwaysStoppedAnimation(0.35)
                  : const AlwaysStoppedAnimation(1),
            );
          },
        )
      : Hero(
        tag: id,
        child: Image.asset(
            photo,
            opacity: isLowStock
                ? const AlwaysStoppedAnimation(0.35)
                : const AlwaysStoppedAnimation(1),
            errorBuilder: (context, error, stackTrace) {
              return Image.network(
                'https://assets.tracegains.net/resources/img/global/no_image.jpg',
                opacity: isLowStock
                    ? const AlwaysStoppedAnimation(0.35)
                    : const AlwaysStoppedAnimation(1),
              );
            },
          ),
      ),
)
          ),
          if (isLowStock) LowStockCard(),
        ],
      ),
    );
  }
}
