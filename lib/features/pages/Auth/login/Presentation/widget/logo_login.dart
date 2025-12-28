import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:two_m_production/core/utils/colors.dart';

class LogoLogin extends StatelessWidget {
  const LogoLogin({super.key, required this.logo});
  final SvgPicture logo;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.gray100,
      radius: 30.r,
      child: SizedBox(height: 30.w, width: 30.w, child: logo),
    );
  }
}
