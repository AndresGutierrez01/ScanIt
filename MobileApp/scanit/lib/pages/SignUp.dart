import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scanit/pages/EmailVerification.dart';
import 'package:scanit/utilites/AppColors.dart';
import 'package:scanit/utilites/Auth.dart';
import 'package:scanit/widgets/FormButton.dart';
import 'package:scanit/widgets/MainBanner.dart';
import 'package:scanit/widgets/SignUpForm.dart';
import 'package:scanit/widgets/SlideLeftRoute.dart';
import 'package:scanit/widgets/SlideRightRoute.dart';
import 'package:scanit/widgets/TextButton.dart';

import 'Login.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool loading = false;
  String error = "";

  signUp() async {
    setState(() {
      loading = true;
    });

    String uid = await Auth.signUp(
        email: email.text,
        password: password.text,
        confirmPassword: confirmPassword.text);

    if (validUID(uid)) {
      Auth.sendVerificationEmail();
      Navigator.of(context).pushReplacement(
        SlideRightRoute(widget: EmailVerification(email: email.text,)),
      );
    }

    setState(() {
      loading = false;
    });
  }

  login() {
    Navigator.of(context).pushReplacement(
      SlideLeftRoute(widget: Login()),
    );
  }

  bool validUID(String uid) {
    if (uid == "ERROR_PASSWORD_MATCH") {
      password.clear();
      confirmPassword.clear();
      error = "Passwords do not match";
      return false;
    } else if (uid == "ERROR_INVALID_EMAIL") {
      email.clear();
      error = "Invalid email";
      return false;
    } else if (uid == "ERROR_WEAK_PASSWORD") {
      password.clear();
      confirmPassword.clear();
      error = "Password must be at least 6 characters";
      return false;
    } else if (uid == "ERROR_EMAIL_ALREADY_IN_USE") {
      email.clear();
      error = "Email already in use";
      return false;
    } else if (uid == "error") {
      error = "Empty field";
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                MainBanner(),
                Padding(
                  padding: EdgeInsets.all(20),
                ),
                SignUpForm(
                  emailCtr: email,
                  passwordCtr: password,
                  passwordConfirmCtr: confirmPassword,
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: error != ""
                      ? Text(
                          error,
                          style: TextStyle(color: AppColors.aqua),
                        )
                      : Text(""),
                ),
                loading
                    ? SpinKitWave(color: AppColors.white, size: 30.0)
                    : FormButton(text: "SIGN UP", onTap: signUp),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                TextButton(
                  text: "Already have an account? Log in here!",
                  onTap: login,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
