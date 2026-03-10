import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/components/buttons/main_button.dart';
import 'package:two_m_production/components/inputs/main_text_form_field.dart';
import 'package:two_m_production/core/constatnts/images.dart';
import 'package:two_m_production/core/extentions/show_dialoges.dart';
import 'package:two_m_production/core/routes/navigation.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/features/pages/Setting/Presentation/cubit/settingCubit.dart';
import 'package:two_m_production/features/pages/Setting/Presentation/cubit/settingState.dart';
import 'package:two_m_production/features/pages/Setting/Presentation/widget/appProduct/add_product_image.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Theme aware styles
    final inputFillColor = AppColors.white;

    return BlocProvider(
      create: (context) => SettingCubit(),
      child: BlocConsumer<SettingCubit, SettingState>(
        listener: (context, state) {
          if (state is SettingLoadingState) {
            return showLoadingDialog(context);
          }
        },
        builder: (context, state) {
          if (state is SettingErrorState || state is SettingSuccessState) {
            Pop(context);
          }
          var cubit = context.read<SettingCubit>();
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
              child: Form(
                key: cubit.key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image Upload
                    AddProductImage(
                      inputFillColor: inputFillColor,
                      cubit: cubit,
                    ),
                    SizedBox(height: 24.r),

                    // Product Name
                    _buildLabel(LocaleKeys.add_product_product_name.tr()),
                    _buildTextField(
                      context,
                      controller: cubit.nameController,
                      hint: LocaleKeys.add_product_enter_product_name.tr(),
                      lable: LocaleKeys.add_product_product_name.tr(),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return LocaleKeys.misc_please_enter_product_name.tr();
                        }
                        return null;
                      },
                      icon: AppAssets.subLableFillSVG,
                    ),
                    SizedBox(height: 16.h),
                    _buildLabel(LocaleKeys.add_product_description.tr()),
                    _buildTextField(
                      context,
                      hint: 'ex:2002s',
                      lable: LocaleKeys.misc_code_product.tr(),
                      controller: cubit.codeController,

                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return LocaleKeys.misc_please_enter_code.tr();
                        }
                        return null;
                      },
                      icon: AppAssets.invoiceFiledSVG,
                    ),
                    SizedBox(height: 16.h),
                    // Description
                    _buildLabel(LocaleKeys.add_product_description.tr()),
                    _buildTextField(
                      context,
                      hint: LocaleKeys.add_product_enter_description.tr(),
                      maxLines: 4,
                      lable: LocaleKeys.misc_description_label.tr(),
                      controller: cubit.descriptionController,

                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return LocaleKeys.misc_please_enter_description.tr();
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),

                    // Stock Quantity
                    _buildLabel(LocaleKeys.add_product_stock_quantity.tr()),
                    _buildTextField(
                      controller: cubit.stockController,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return LocaleKeys.misc_please_enter_stock.tr();
                        }
                        return null;
                      },
                      ketboardType: TextInputType.number,

                      context,
                      hint: 'ex:100',
                      lable: LocaleKeys.add_product_stock_quantity.tr(),
                      icon: AppAssets.categoryFiledSVG,
                    ),
                    SizedBox(height: 16.h),

                    // Price
                    _buildLabel(LocaleKeys.add_product_price.tr()),
                    _buildTextField(
                      context,
                      controller: cubit.priceController,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return LocaleKeys.misc_please_enter_price.tr();
                        }
                        return null;
                      },
                      ketboardType: TextInputType.number,
                      hint: 'ex:350',
                      icon: AppAssets.walletSVG,
                      lable: LocaleKeys.misc_price.tr(),
                    ),
                    SizedBox(height: 32.h),

                    MainButton(
                      buttonText: LocaleKeys.add_product_title.tr(),
                      onPressed: () {
                        if (cubit.key.currentState!.validate()) {
                          if (cubit.selectedMedia.isEmpty) {
                            showMyDialog(
                              context,
                              LocaleKeys.misc_please_select_image.tr(),
                              type: DialogType.warning,
                            );
                          } else
                            cubit.addProduct(context);
                        }
                      },
                      borderRadius: 10.r,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
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
    String? Function(String?)? validator,
    TextInputType? ketboardType,
    String? lable,
    TextEditingController? controller,
  }) {
    return MainTextFormField(
      ispassword: false,
      controller: controller,
      colorFill: AppColors.gray200,
      hint: hint,
      label: lable,
      ketboardType: ketboardType,
      textInputNext: TextInputAction.next,
      validator: validator,
      maxTextLines: maxLines,
      prefixIcon: icon,
    );
  }
}
