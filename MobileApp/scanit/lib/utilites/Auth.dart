import 'package:firebase_auth/firebase_auth.dart';

class Auth{
  static Future<bool> login({String email, String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      return false;
    }
  }
}