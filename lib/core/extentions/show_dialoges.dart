import 'package:flutter/material.dart';
import 'package:two_m_production/core/constatnts/images.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:lottie/lottie.dart';

enum DialogType { error, success }

show_Dialog(
  BuildContext context,
  String message, {
  DialogType type = DialogType.error,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor:
          (type == DialogType.error) ? AppColors.error : AppColors.success,
      content: Text(message),
    ),
  );
}

showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder:
        (context) => Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Expanded(child: Lottie.asset(AppAssets.loaderCirclerJSON))],
          ),
        ),
  );
}

