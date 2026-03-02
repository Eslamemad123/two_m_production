import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> isOnline() async {
  final result = await Connectivity().checkConnectivity();

  if (result.contains(ConnectivityResult.mobile) ||
      result.contains(ConnectivityResult.wifi)) {
    return true;
  }

  return false;
}
