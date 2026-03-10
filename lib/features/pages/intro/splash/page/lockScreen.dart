import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:two_m_production/core/routes/navigation.dart';
import 'package:two_m_production/core/routes/routes.dart';
import 'package:two_m_production/core/services/cache/LocalHelper.dart';
import 'package:two_m_production/features/pages/intro/splash/widget/biometric_service.dart';

class AppLockScreen extends StatefulWidget {
  const AppLockScreen({super.key});

  @override
  State<AppLockScreen> createState() => _AppLockScreenState();
}

class _AppLockScreenState extends State<AppLockScreen> {
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _unlock();
    });
  }

  Future<void> _unlock() async {
    log('start biometric');

    bool result = await BiometricService().authenticate();

    if (!mounted) return;

    if (!result) {
      await auth.stopAuthentication();
      exit(0);
    }

    final bool isLogin = Localhelper.getBool(Localhelper.kUserIsLogin) ?? false;

    if (isLogin) {
      pushReplacement(context, Routes.main);
    } else {
      pushReplacement(context, Routes.login);
    }
  }

  Future<bool> _onBackPressed() async {
    await auth.stopAuthentication();

    exit(0);

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
