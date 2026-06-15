import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/extentions/show_dialoges.dart';
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
  final ProductModel product;
  final bool isSheet;

  const AddStockSheet({super.key, required this.product, this.isSheet = true});

  @override
  State<AddStockSheet> createState() => _AddStockSheetState();
}

class _AddStockSheetState extends State<AddStockSheet> {
  int _quantityToAdd = 0;

  void _updateQty(int change, HomeCubit cubit) {
    setState(() {
      _quantityToAdd += change;
      if (_quantityToAdd < 0) _quantityToAdd = 0;
      cubit.addProductController.text = _quantityToAdd.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = BlocProvider(
      create: (_) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeLoadingState) {
            showLoadingDialog(context);
          }
        },
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();

          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              24.w,
              12.h,
              24.w,
              MediaQuery.of(context).viewInsets.bottom + 10.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.isSheet)
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
                    style: AppFontStyles.getSize18(fontWeight: FontWeight.bold),
                  ),
                ),

                SizedBox(height: 24.h),

                productAddToStock(product: widget.product),

                SizedBox(height: 24.h),

                Text(
                  LocaleKeys.common_quantity.tr(),
                  style: AppFontStyles.getSize14(fontWeight: FontWeight.w600),
                ),

                SizedBox(height: 12.h),

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
                          color: Colors.white,
                        ),
                        child: TextField(
                          controller: cubit.addProductController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: AppFontStyles.getSize18(
                            fontWeight: FontWeight.bold,
                            fontColor: AppColors.textPrimary,
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
                  style: AppFontStyles.getSize14(fontWeight: FontWeight.w600),
                ),

                SizedBox(height: 12.h),

                DateTextForm(homeCubit: cubit),

                SizedBox(height: 16.h),

                NotesFiledAddToStock(cubit: cubit),

                ButtonsAddToStock(
                  cubit: cubit,
                  idProduct: widget.product.id,
                  name: normalizeName(widget.product.name),
                ),
              ],
            ),
          );
        },
      ),
    );

    if (widget.isSheet) {
      return SafeArea(
        child: Material(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          child: content,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.add_stock_title.tr()),
        centerTitle: true,
      ),
      body: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(child: content),
      ),
    );
  }
}
  
String normalizeName(String name) {
  final first = name.trim().split(' ').first;

  if (first == 'X') {
    return 'Large';
  }

  return first;
}
