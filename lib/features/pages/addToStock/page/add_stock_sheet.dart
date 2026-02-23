import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:two_m_production/features/pages/Home/Data/Model/productModel.dart';
import 'package:two_m_production/features/pages/Home/Presentation/cubit/homeCubit.dart';
import 'package:two_m_production/features/pages/Home/Presentation/cubit/homeState.dart';
import 'package:two_m_production/features/pages/addToStock/widget/buttons_add_to_stock.dart';
import 'package:two_m_production/features/pages/addToStock/widget/conter_on_tap_add_to_stock.dart';
import 'package:two_m_production/features/pages/addToStock/widget/date_text_form.dart';
import 'package:two_m_production/features/pages/addToStock/widget/notes_filed_add_to_stock.dart';
import 'package:two_m_production/features/pages/addToStock/widget/product_add_to_stock.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class AddStockSheet extends StatefulWidget {
  final ProductModel? product;

  const AddStockSheet({super.key, this.product});

  @override
  State<AddStockSheet> createState() => _AddStockSheetState();
}

class _AddStockSheetState extends State<AddStockSheet> {
  int _quantityToAdd = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   _qtyController.addListener(() {
  //     final val = int.tryParse(_qtyController.text);
  //     if (val != null && val != _quantityToAdd) {
  //       setState(() => _quantityToAdd = val);
  //     }
  //   });
  // }
  // @override
  // void dispose() {
  //   _qtyController.dispose();
  //   super.dispose();
  // }

  void _updateQty(int change, HomeCubit cubit) {
    setState(() {
      _quantityToAdd += change;
      if (_quantityToAdd < 0) _quantityToAdd = 0;
      cubit.addProductController.text = _quantityToAdd.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var cubit = context.read<HomeCubit>();
          return SafeArea(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
              ),
              padding: EdgeInsets.fromLTRB(
                24.w,
                12.h,
                24.w,
                MediaQuery.of(context).viewInsets.bottom + 10.h,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40.w,
                        height: 4.h,
                        margin: EdgeInsets.only(bottom: 24.h),
                        decoration: BoxDecoration(
                          color: AppColors.gray300,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        LocaleKeys.add_stock_title.tr(),
                        style: AppFontStyles.getSize18(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    productAddToStock(isDark: isDark, product: widget.product!),
                    SizedBox(height: 24.h),
                    Text(
                      LocaleKeys.common_quantity
                          .tr(), // Or specific key if available
                      style: AppFontStyles.getSize14(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    //counter
                    Row(
                      children: [
                        conterOnTapAddToStock(
                          context: context,
                          icon: Icons.remove,
                          onTap: () => _updateQty(-10, cubit),
                          isOutlined: true,
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Container(
                            height: 48.h,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.borderLight),
                              borderRadius: BorderRadius.circular(12.r),
                              color: isDark
                                  ? AppColors.darkSurfaceAlt
                                  : Colors.white,
                            ),
                            child: TextField(
                              controller: cubit.addProductController,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: AppFontStyles.getSize18(
                                fontWeight: FontWeight.bold,
                                fontColor: isDark
                                    ? Colors.white
                                    : AppColors.textPrimary,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        conterOnTapAddToStock(
                          context: context,
                          icon: Icons.add,
                          onTap: () => _updateQty(10, cubit),
                          isOutlined: false,
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      LocaleKeys.add_stock_date_received.tr(),
                      style: AppFontStyles.getSize14(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    DateTextForm(homeCubit: cubit),
                    SizedBox(height: 16.h),
                    NotesFiledAddToStock(cubit: cubit),

                    // Actions
                    ButtonsAddToStock(
                      cubit: cubit,
                      idProduct: widget.product!.id,
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
}
