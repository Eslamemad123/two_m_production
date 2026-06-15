import 'dart:developer';

import 'package:local_auth/local_auth.dart';

class BiometricService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> authenticate() async {
    try {
      log('111');

      final bool supported = await _auth.isDeviceSupported();
      final bool canCheck = await _auth.canCheckBiometrics;
      log('222');

      if (!supported && !canCheck) {
        log('333');

        return false;
      }
      log('444');

      final bool authenticated = await _auth.authenticate(
        localizedReason: 'Authenticate to open the app',
        persistAcrossBackgrounding: true,
      );
      log('555');

      return authenticated;
    } catch (e) {
      log('error: $e');
      return false;
    }
  }
}
