import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:two_m_production/core/routes/navigation.dart';
import 'package:two_m_production/core/routes/routes.dart';
import 'package:two_m_production/core/services/cache/LocalHelper.dart';
import 'package:two_m_production/features/pages/intro/splash/widget/splash_u_i.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2, microseconds: 260), () {
      final bool isLogin =
          Localhelper.getBool(Localhelper.kUserIsLogin) ?? false;
      final bool isLock = Localhelper.getBool(Localhelper.kLock) ?? false;
      if (isLock) {
        pushReplacement(context, Routes.appLock);
      }
      else if (isLogin) {
        pushReplacement(context, Routes.main);
      } else {
        pushReplacement(context, Routes.login);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashUI(),
     
    );
  }
}
