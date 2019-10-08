import 'package:flutter/material.dart';
import 'package:scanit/utilites/AppColors.dart';
import 'package:scanit/widgets/LoginForm.dart';
import 'package:scanit/widgets/FormButton.dart';
import 'package:scanit/widgets/MainBanner.dart';
import 'package:scanit/widgets/TextButton.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  login() {
    print("Logging in....");
  }

  forgotPassword(){

  }

  signUp() {
    print("Routing to sign up page");
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
                  FormButton(text: "LOG IN", onTap: login),
                  Padding(padding: EdgeInsets.all(10),),
                  TextButton(
                    text: "Forgot password? Tap here!",
                    onPressed: forgotPassword,
                  ),
                  TextButton(
                    text: "Don't have an account? Sign up here!",
                    onPressed: signUp,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
