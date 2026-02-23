import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/features/pages/Home/Presentation/cubit/homeCubit.dart';
import 'package:two_m_production/features/pages/RecordSale/presentation/cubit/order_cubit.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class DateTextForm extends StatefulWidget {
  DateTextForm({super.key, this.homeCubit, this.orderCubit});
  HomeCubit? homeCubit;
  OrderCubit? orderCubit;

  @override
  State<DateTextForm> createState() => _DateTextFormState();
}

class _DateTextFormState extends State<DateTextForm> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: (widget.homeCubit != null)
          ? widget.homeCubit?.dateController
          : widget.orderCubit?.dateController,
      onTap: () async {
        var selectDate = await showDatePicker(
          context: context,
          firstDate: DateTime.utc(1900),
          initialDate: DateTime.now(),
          lastDate: DateTime.now(),
        );
        if (selectDate != null) {
          setState(() {
            String formattedDate = DateFormat('yyyy-MM-dd').format(selectDate);
            if (widget.homeCubit != null) {
              widget.homeCubit!.dateController!.text = formattedDate;
            } else {
              widget.orderCubit!.dateController.text = formattedDate;
            }
          });
        }
      },
      readOnly: true,
      //  controller: cubit.dateController,
      decoration: InputDecoration(
        hint: Text(LocaleKeys.home_clickToSelctDate.tr()),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        suffixIcon: Icon(
          Icons.calendar_month_sharp,
          color: Theme.of(context).colorScheme.primary,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: AppColors.gray300, width: 1.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: Colors.red, width: 1.w),
        ),
      ),
    );
  }
}
