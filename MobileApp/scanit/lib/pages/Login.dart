import 'package:flutter/material.dart';
import '../widgets/MainBanner.dart';
import '../widgets/LoginForm.dart';
import '../widgets/FormButton.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  login(){

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
              FormButton(text: "Login", onTap: login())
            ],
          ),
        ),
      )),
    );
  }
}
