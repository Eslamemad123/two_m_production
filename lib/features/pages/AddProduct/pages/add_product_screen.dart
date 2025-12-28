import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/components/buttons/main_button.dart';
import 'package:two_m_production/components/inputs/main_text_form_field.dart';
import 'package:two_m_production/core/constatnts/images.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/features/pages/AddProduct/widget/add_product_image.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Theme aware styles
    final inputFillColor = Theme.of(context).brightness == Brightness.dark
        ? AppColors.darkSurfaceAlt
        : AppColors.white;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          LocaleKeys.add_product_title.tr(),
          style: AppFontStyles.getSize18(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.transparent,
        elevation: 0,
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image Upload
            AddProductImage(inputFillColor: inputFillColor),
            SizedBox(height: 24.r),

            // Product Name
            _buildLabel(LocaleKeys.add_product_product_name.tr()),
            _buildTextField(
              context,
              hint: LocaleKeys.add_product_enter_product_name.tr(),
            ),
            SizedBox(height: 16.h),

            // Description
            _buildLabel(LocaleKeys.add_product_description.tr()),
            _buildTextField(
              context,
              hint: LocaleKeys.add_product_enter_description.tr(),
              maxLines: 4,
            ),
            SizedBox(height: 16.h),

            // Stock Quantity
            _buildLabel(LocaleKeys.add_product_stock_quantity.tr()),
            _buildTextField(
              context,
              hint: '0',
              icon: AppAssets.categoryFiledSVG,
            ),
            SizedBox(height: 16.h),

            // Price
            _buildLabel(LocaleKeys.add_product_price.tr()),
            _buildTextField(context, hint: '0', icon: AppAssets.walletSVG),
            SizedBox(height: 32.h),

            MainButton(
              buttonText: LocaleKeys.add_product_title.tr(),
              onPressed: () {},
              borderRadius: 10.r,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8..r),
      child: Text(
        label,
        style: AppFontStyles.getSize14(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required String hint,
    int maxLines = 1,
    String? icon,
  }) {
    return MainTextFormField(
      ispassword: false,
      colorFill: AppColors.gray200,
      hint: hint,
      maxTextLines: maxLines,
      prefixIcon: icon,
    );
  }
}
