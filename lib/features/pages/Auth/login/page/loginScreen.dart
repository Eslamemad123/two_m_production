import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:two_m_production/components/buttons/main_button.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:gap/gap.dart';
import 'package:two_m_production/features/pages/Auth/login/widget/login_filed.dart';
import 'package:two_m_production/features/pages/Auth/login/widget/login_header.dart';
import 'package:two_m_production/features/pages/Auth/login/widget/login_with_other.dart';
import 'package:two_m_production/features/pages/Main/page/NavBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LoginHeader(),

              LoginFiled(),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.r),
                child: MainButton(
                  buttonText: LocaleKeys.auth_login.tr(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return NavBar();
                        },
                      ),
                    );
                  },
                ),
              ),

              Gap(10),

              LoginWithOther(),
              Gap(10),
            ],
          ),
        ),
      ),
    );
  }
}
