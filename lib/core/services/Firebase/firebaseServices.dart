import 'package:firebase_auth/firebase_auth.dart';

class ForebaseProvider {
  static Future<void> login(String email, String password) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
  }
}
