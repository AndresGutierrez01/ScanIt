import 'package:flutter/material.dart';
import '../widgets/MainBanner.dart';
import '../widgets/LoginForm.dart';
import '../widgets/FormButton.dart';
import '../widgets/TextButton.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  login(){
    print("Logging in....");
  }

  signUp(){
    print("Routing to sign up page");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              MainBanner(),
              LoginForm(emailController: email,passwordController: password,),
              FormButton(text: "Login", onTap: login),
              TextButton(text: "Don't have an account? Sign up here!", onTap: signUp,)
            ],
          ),
        ),
      )),
    );
  }
}
