// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';

// ignore: must_be_immutable
class MainTextFormField extends StatefulWidget {
  MainTextFormField({
    super.key,
    this.controller,
    this.hint,
    this.maxTextLines = 1,
    this.validator,
    required this.ispassword,
    this.colorFill,
    this.label,
    this.prefixIcon,
    this.sufixIcon,
    this.textColor,
    this.textInputNext,
    this.ketboardType,
    this.onFieldSubmitted,
  });
  bool ispassword = false;
  String? Function(String?)? validator;
  int maxTextLines;
  String? hint;
  final TextEditingController? controller;
  final Color? colorFill;
  final String? label;
  final String? prefixIcon;
  final String? sufixIcon;
  final Color? textColor;
  final TextInputType? ketboardType;
  final TextInputAction? textInputNext;
  final void Function(String)? onFieldSubmitted;
  @override
  State<MainTextFormField> createState() => _MainTextFormFieldState();
}

class _MainTextFormFieldState extends State<MainTextFormField> {
  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: TextFormField(
        obscureText: widget.ispassword && isObsecure,
        validator: widget.validator,
        controller: widget.controller,
        textInputAction: widget.textInputNext ?? TextInputAction.none,
        maxLines: widget.maxTextLines,
        onFieldSubmitted: widget.onFieldSubmitted,
        style: AppFontStyles.getSize18(
          fontColor:
              Theme.of(context).textTheme.bodyLarge?.color ??
              AppColors.textPrimary,
        ),
        keyboardType: widget.ketboardType,
        decoration: InputDecoration(
          label: Text(
            widget.label ?? "",
            style: AppFontStyles.getSize14(
              fontColor:
                  widget.textColor ??
                  Theme.of(context).textTheme.bodySmall?.color ??
                  AppColors.gray400,
            ),
          ),

          filled: true,
          fillColor:
              widget.colorFill ??
              Theme.of(context).inputDecorationTheme.fillColor ??
              AppColors.gray200,
          suffixIcon: widget.ispassword
              ? Transform.flip(
                  flipY: true,
                  child: IconButton(
                    icon: Icon(
                      isObsecure ? Icons.visibility : Icons.visibility_off,
                      color: AppColors.primaryDark,
                    ),
                    onPressed: () {
                      setState(() {
                        isObsecure = !isObsecure;
                      });
                    },
                  ),
                )
              : null,
          prefixIconConstraints: BoxConstraints(
            maxHeight: 35.w,
            maxWidth: 35.w,
          ),
          prefixIcon: (widget.prefixIcon != null)
              ? Padding(
                  padding: EdgeInsets.only(left: 8.r, right: 5.r),
                  child: SvgPicture.asset(
                    widget.prefixIcon ?? '',
                    colorFilter: ColorFilter.mode(
                      AppColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                )
              : null,

          hint: Text(
            widget.hint ?? "",
            style: AppFontStyles.getSize14(
              fontColor:
                  Theme.of(context).textTheme.bodySmall?.color ??
                  AppColors.gray400,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(
              color: AppColors.gray200.withValues(alpha: 0.2),
              width: 1.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(color: AppColors.primaryLight, width: 1.w),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(color: Colors.red, width: 1.w),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(color: Colors.red, width: 1.w),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(color: Colors.red, width: 1.w),
          ),
        ),
      ),
    );
  }
}
