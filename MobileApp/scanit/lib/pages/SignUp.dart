import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scanit/utilites/AppColors.dart';
import 'package:scanit/widgets/FormButton.dart';
import 'package:scanit/widgets/MainBanner.dart';
import 'package:scanit/widgets/SignUpForm.dart';
import 'package:scanit/widgets/SlideLeftRoute.dart';
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

  signUp(){
    setState(() {
      loading = true;
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
                SignUpForm(
                  emailCtr: email,
                  passwordCtr: password,
                  passwordConfirmCtr: confirmPassword,
                ),
                loading
                ?SpinKitWave(color: AppColors.white, size: 30.0)
                :FormButton(text: "SIGN UP", onTap: signUp),
                Padding(padding: EdgeInsets.all(10),),
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
