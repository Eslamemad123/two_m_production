import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_m_production/components/buttons/main_button.dart';
import 'package:two_m_production/core/extentions/show_dialoges.dart';
import 'package:two_m_production/core/routes/navigation.dart';
import 'package:two_m_production/core/routes/routes.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:gap/gap.dart';
import 'package:two_m_production/features/pages/Auth/login/Presentation/cubit/auth_cubit.dart';
import 'package:two_m_production/features/pages/Auth/login/Presentation/cubit/auth_state.dart';
import 'package:two_m_production/features/pages/Auth/login/Presentation/widget/login_filed.dart';
import 'package:two_m_production/features/pages/Auth/login/Presentation/widget/login_header.dart';
import 'package:two_m_production/features/pages/Auth/login/Presentation/widget/login_with_other.dart';
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
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthLoadingState) {
                showLoadingDialog(context);
              } else if (state is AuthSuccessState) {
                PupushAndRemoveUntilsh(context, Routes.main);
              } else if (state is AuthErrorState) {
                showMyDialog(context, state.error, type: DialogType.error);
                Pop(context);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LoginHeader(),

                LoginFiled(cubit: context.read<AuthCubit>()),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.r),
                  child: MainButton(
                    buttonText: LocaleKeys.auth_login.tr(),
                    onPressed: () {
                      if (context
                          .read<AuthCubit>()
                          .keyLogin
                          .currentState!
                          .validate()) {
                        context.read<AuthCubit>().login();
                      }
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
      ),
    );
  }
}
