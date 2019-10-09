import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  static Future<String> signUp({String email, String password, String confirmPassword}) async {

    if(password != confirmPassword){
      return "ERROR_PASSWORD_MATCH";
    }
    try {
      AuthResult auth = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      //FirestoreFunction.create(auth.user.uid)
      return auth.user.uid;
    } catch (e) {
      return e.code.toString();
    }
  }
  static Future<bool> resetPassword({@required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      return false;
    }
  }

  static void sendVerificationEmail() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    user.sendEmailVerification();
  }
  static Future<bool> isEmailVerified() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.isEmailVerified;
  }
}