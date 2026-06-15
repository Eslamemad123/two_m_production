import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:two_m_production/core/constatnts/images.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/features/pages/RecordSale/Data/model/customer_model.dart';
import 'package:two_m_production/features/pages/oreder/presentation/pages/customer_details_screen.dart';

class OrderCard extends StatefulWidget {
  final CustomerModel order; // We keep the variable name 'order' to minimize changes elsewhere in list builders if needed, but it is a CustomerModel.

  const OrderCard({super.key, required this.order});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final customer = widget.order;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Sort customer orders descending by date
    final sortedOrders = List<OrderHistoryModel>.from(customer.orders)
      ..sort((a, b) => b.date.compareTo(a.date));

    // Limit to latest 3 orders
    final latestOrders = sortedOrders.take(3).toList();

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

    // Check if the latest order has vodafoneCash or inDrive
    final bool latestVodafone = sortedOrders.isNotEmpty && sortedOrders.first.vodafoneCash;
    final bool latestInDrive = sortedOrders.isNotEmpty && sortedOrders.first.inDrive;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20.r),
        child: InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          onLongPress: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CustomerDetailsScreen(customer: customer),
              ),
            );
          },
          borderRadius: BorderRadius.circular(20.r),
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Collapsed State Header
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20.r,
                      backgroundColor: avatarColor,
                      child: firstLetter.isNotEmpty
                          ? Text(
                              firstLetter,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            )
                          : Icon(
                              Icons.person,
                              size: 20.sp,
                              color: Colors.white,
                            ),
                    ),
                    Gap(12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            customer.name.isNotEmpty ? customer.name : 'بدون اسم',
                            style: AppFontStyles.getSize16(
                              fontWeight: FontWeight.bold,
                              fontColor: AppColors.textPrimary,
                            ),
                          ),
                          Gap(2.h),
                          Row(
                            children: [
                              Text(
                                customer.phone.isNotEmpty ? customer.phone : 'بدون رقم هاتف',
                                style: AppFontStyles.getSize12(
                                  fontColor: AppColors.textSecondary,
                                ),
                              ),
                              if (latestVodafone || latestInDrive) ...[
                                Gap(10.w),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (latestVodafone) ...[
                                      Image.asset(AppAssets.vodafone, width: 18.w, height: 18.h),
                                      Gap(6.w),
                                    ],
                                    if (latestInDrive)
                                      Image.asset(AppAssets.inDrive, width: 16.w, height: 16.h),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      _isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
                Gap(12.h),
                const Divider(),
                Gap(8.h),

                // Stats Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatItem('الطلبات', customer.totalOrders.toString()),
                    _buildStatItem('القطع', customer.totalItems.toString()),
                    _buildStatItem('إجمالي المدفوع', '${customer.totalSpent.toStringAsFixed(0)} EGP', isPrimaryColor: true),
                  ],
                ),

                // Expanded Section: Latest 3 Orders
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 300),
                  crossFadeState: _isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  firstChild: const SizedBox.shrink(),
                  secondChild: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(16.h),
                      const Divider(),
                      Gap(8.h),
                      Text(
                        'آخر 3 طلبات:',
                        style: AppFontStyles.getSize14(
                          fontWeight: FontWeight.bold,
                          fontColor: AppColors.textPrimary,
                        ),
                      ),
                      Gap(10.h),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: latestOrders.length,
                        separatorBuilder: (context, index) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Divider(color: Colors.grey.shade300, thickness: 0.5),
                        ),
                        itemBuilder: (context, index) {
                          final order = latestOrders[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'طلب #${order.orderId}',
                                    style: AppFontStyles.getSize14(
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
                              Gap(6.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Wrap(
                                      spacing: 8.w,
                                      runSpacing: 4.h,
                                      children: order.sizes.map((s) {
                                        return Text(
                                          '${s.size}: ${s.quantity}',
                                          style: AppFontStyles.getSize12(
                                            fontWeight: FontWeight.w600,
                                            fontColor: AppColors.textSecondary,
                                          ),
                                        );
                                      }).toList(),
                                    ),
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
                                        style: AppFontStyles.getSize14(
                                          fontWeight: FontWeight.bold,
                                          fontColor: AppColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, {bool isPrimaryColor = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: AppFontStyles.getSize14(
            fontWeight: FontWeight.bold,
            fontColor: isPrimaryColor ? AppColors.primary : AppColors.textPrimary,
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
}
