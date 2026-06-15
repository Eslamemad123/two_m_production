import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:two_m_production/core/constatnts/images.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/features/pages/RecordSale/Data/model/customer_model.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class CustomerDetailsScreen extends StatelessWidget {
  final CustomerModel customer;

  const CustomerDetailsScreen({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    // Sort all orders descending by date
    final sortedOrders = List<OrderHistoryModel>.from(customer.orders)
      ..sort((a, b) => b.date.compareTo(a.date));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          customer.name.isNotEmpty ? customer.name : 'بدون اسم',
          style: AppFontStyles.getSize18(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Customer Info Card
              _buildCustomerProfileCard(context),
              Gap(24.h),
              
              // Section Header
              Text(
                'سجل الطلبات (${customer.totalOrders})',
                style: AppFontStyles.getSize16(
                  fontWeight: FontWeight.bold,
                  fontColor: AppColors.textPrimary,
                ),
              ),
              Gap(12.h),

              // Order History List
              if (sortedOrders.isEmpty)
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 40.h),
                    child: Text(
                      LocaleKeys.misc_no_orders.tr(),
                      style: AppFontStyles.getSize14(fontColor: AppColors.textSecondary),
                    ),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: sortedOrders.length,
                  separatorBuilder: (context, index) => Gap(16.h),
                  itemBuilder: (context, index) {
                    return _buildOrderHistoryCard(context, sortedOrders[index]);
                  },
                ),
              Gap(24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomerProfileCard(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Deterministic random color based on phone or id
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.purple,
      Colors.orange,
      Colors.teal,
      Colors.indigo,
      Colors.pink,
      Colors.brown,
      Colors.deepOrange,
    ];

    final String keySource = customer.phone.trim().isNotEmpty 
        ? customer.phone.trim() 
        : customer.id;
    final int colorIndex = keySource.hashCode.abs() % colors.length;
    final Color avatarColor = colors[colorIndex];

    // Avatar content: first letter of name or person icon
    final String firstLetter = customer.name.trim().isNotEmpty
        ? customer.name.trim().substring(0, 1).toUpperCase()
        : '';
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark 
            ? [AppColors.darkSurface, AppColors.darkSurfaceAlt]
            : [Colors.white, AppColors.backgroundSoft],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
            blurRadius: 15.r,
            offset: Offset(0, 8.h),
          ),
        ],
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28.r,
                backgroundColor: avatarColor,
                child: firstLetter.isNotEmpty
                    ? Text(
                        firstLetter,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22.sp,
                        ),
                      )
                    : Icon(
                        Icons.person,
                        size: 28.sp,
                        color: Colors.white,
                      ),
              ),
              Gap(16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customer.name.isNotEmpty ? customer.name : 'بدون اسم',
                      style: AppFontStyles.getSize24(
                        fontWeight: FontWeight.bold,
                        fontColor: AppColors.textPrimary,
                      ),
                    ),
                    Gap(4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.phone_outlined,
                          size: 14.sp,
                          color: AppColors.textSecondary,
                        ),
                        Gap(6.w),
                        Text(
                          customer.phone.isNotEmpty ? customer.phone : 'بدون رقم هاتف',
                          style: AppFontStyles.getSize14(
                            fontColor: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Gap(20.h),
          const Divider(),
          Gap(12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem('الطلبات', customer.totalOrders.toString(), Icons.shopping_bag_outlined),
              _buildStatItem('القطع', customer.totalItems.toString(), Icons.grid_view_outlined),
              _buildStatItem('إجمالي المدفوع', '${customer.totalSpent.toStringAsFixed(0)} EGP', Icons.payments_outlined),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 20.sp, color: AppColors.primary),
        Gap(6.h),
        Text(
          value,
          style: AppFontStyles.getSize16(
            fontWeight: FontWeight.bold,
            fontColor: AppColors.textPrimary,
          ),
        ),
        Gap(2.h),
        Text(
          label,
          style: AppFontStyles.getSize12(
            fontColor: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildOrderHistoryCard(BuildContext context, OrderHistoryModel order) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'طلب #${order.orderId}',
                style: AppFontStyles.getSize16(
                  fontWeight: FontWeight.bold,
                  fontColor: AppColors.textPrimary,
                ),
              ),
              Text(
                order.date,
                style: AppFontStyles.getSize12(
                  fontColor: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          Gap(12.h),
          const Divider(),
          Gap(12.h),
          
          // Size items list
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: order.sizes.map((s) {
              return Padding(
                padding: EdgeInsets.only(bottom: 6.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      s.size,
                      style: AppFontStyles.getSize14(
                        fontColor: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${s.quantity} قطع',
                      style: AppFontStyles.getSize14(
                        fontColor: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          Gap(12.h),
          const Divider(),
          Gap(12.h),

          // Price + Pieces summary
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.inventory_2_outlined, size: 16.sp, color: AppColors.textSecondary),
                  Gap(6.w),
                  Text(
                    '${order.itemsCount} قطع',
                    style: AppFontStyles.getSize14(
                      fontWeight: FontWeight.w600,
                      fontColor: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  if (order.vodafoneCash) ...[
                    Image.asset(AppAssets.vodafone, width: 18.w, height: 18.h),
                    Gap(6.w),
                  ],
                  if (order.inDrive) ...[
                    Image.asset(AppAssets.inDrive, width: 16.w, height: 16.h),
                    Gap(6.w),
                  ],
                  Text(
                    '${order.price.toStringAsFixed(0)} EGP',
                    style: AppFontStyles.getSize18(
                      fontWeight: FontWeight.bold,
                      fontColor: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
