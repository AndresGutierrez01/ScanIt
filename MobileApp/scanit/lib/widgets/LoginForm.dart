import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  LoginForm(
      {@required this.emailController, @required this.passwordController});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Email",
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
            ),
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          Text(
            "Password",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextField(
            controller: passwordController,
            obscureText: true,
          ),
        ],
      ),
    );
  }
}
