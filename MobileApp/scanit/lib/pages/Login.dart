import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scanit/pages/ForgotPassword.dart';
import 'package:scanit/pages/SignUp.dart';
import 'package:scanit/utilites/AppColors.dart';
import 'package:scanit/widgets/LoginForm.dart';
import 'package:scanit/widgets/FormButton.dart';
import 'package:scanit/widgets/MainBanner.dart';
import 'package:scanit/widgets/SlideRightRoute.dart';
import 'package:scanit/widgets/TextButton.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool loading = false;

  login() {
    setState(() {
     loading = true; 
    });
  }

  forgotPassword(){
    Navigator.of(context).pushReplacement(
      SlideRightRoute(widget: ForgotPassword()),
    );
  }

  signUp() {
    Navigator.of(context).pushReplacement(
      SlideRightRoute(widget: SignUp()),
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
                  Padding(padding: EdgeInsets.all(20),),
                  LoginForm(
                    emailCtr: email,
                    passwordCtr: password,
                  ),
                  loading
                  ?SpinKitWave(color: AppColors.white, size: 30.0)
                  :FormButton(text: "LOG IN", onTap: login),
                  Padding(padding: EdgeInsets.all(10),),
                  TextButton(
                    text: "Forgot password? Tap here!",
                    onTap: forgotPassword,
                  ),
                  TextButton(
                    text: "Don't have an account? Sign up here!",
                    onTap: signUp,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
