import 'package:flutter/material.dart';
import '../widgets/MainBanner.dart';
import '../widgets/LoginForm.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              MainBanner(),
              LoginForm(emailController: email,passwordController: password,)
            ],
          ),
        ),
      )),
    );
  }
}
