import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scanit/pages/PasswordReset.dart';
import 'package:scanit/utilites/AppColors.dart';
import 'package:scanit/utilites/Auth.dart';
import 'package:scanit/widgets/ForgotPasswordForm.dart';
import 'package:scanit/widgets/FormButton.dart';
import 'package:scanit/widgets/MainBanner.dart';
import 'package:scanit/widgets/SlideLeftRoute.dart';
import 'package:scanit/widgets/TextButton.dart';

import 'Login.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController email = TextEditingController();
  bool loading = false;
  String error = "";

  resetPassword() async {
    setState(() {
      loading = true;
    });

    if (await Auth.resetPassword(email: email.text)) {
      Navigator.of(context).pushReplacement(
        SlideLeftRoute(widget: PasswordReset(email: email.text)),
      );
    }

    setState(() {
      error = "Email not found";
      email.clear();
      loading = false;
    });
  }

  login() {
    Navigator.of(context).pushReplacement(
      SlideLeftRoute(widget: Login()),
    );
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
                ForgotPasswordForm(
                  emailCtr: email,
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
                    : FormButton(text: "RESET PASSWORD", onTap: resetPassword),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                TextButton(
                  text: "Password reset? Log in here!",
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
