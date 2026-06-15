import 'package:flutter/material.dart';
import 'package:two_m_production/core/constatnts/images.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:lottie/lottie.dart';

enum DialogType { error, success, warning }

void showMyDialog(
  BuildContext context,
  String message, {
  DialogType type = DialogType.error,
}) {
  final icon = switch (type) {
    DialogType.error => Icons.error_outline,
    DialogType.warning => Icons.warning_amber_outlined,
    DialogType.success => Icons.check_circle_outline,
  };

  final bgColor = switch (type) {
    DialogType.error => AppColors.error,
    DialogType.warning => AppColors.warning,
    DialogType.success => AppColors.success,
  };

  final messenger = ScaffoldMessenger.of(context);

  messenger.showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(20),
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Text(message, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
      action: SnackBarAction(
        label: '✕',
        textColor: Colors.white,
        onPressed: () {
          messenger.hideCurrentSnackBar();
        },
      ),
    ),
  );
}

showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Expanded(child: Lottie.asset(AppAssets.loaderCirclerJSON))],
      ),
    ),
  );
}
