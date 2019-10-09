import 'package:flutter/material.dart';
import 'package:scanit/utilites/AppColors.dart';
import 'package:scanit/widgets/SlideLeftRoute.dart';
import 'package:scanit/widgets/TextButton.dart';

import 'Login.dart';

class EmailVerification extends StatefulWidget {
  final String email;
  EmailVerification({@required this.email});
  @override
  _EmailVerificationState createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  TextEditingController email = TextEditingController();
  bool loading = false;

  resetPassword() {
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
                Icon(
                  Icons.email,
                  size: 75,
                  color: AppColors.aqua,
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "PLEASE VERIFY YOUR EMAIL ADDRESS",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: AppColors.white),
                  ),
                )),
                Container(
                  margin: EdgeInsets.all(40),
                  child: Center(
                      child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                          color: AppColors.white,
                          fontFamily: "Montserrat",
                          fontSize: 18),
                      children: <TextSpan>[
                        TextSpan(
                          text: "We sent a verification email to ",
                        ),
                        TextSpan(
                            text: "${widget.email}",
                            style: TextStyle(color: AppColors.aqua)),
                        TextSpan(
                            text:
                                ". Click the link in the email to verify your email and get started with SCANIT. Check your spam folder if the email is not found.")
                      ],
                    ),
                  )),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
                TextButton(
                  text: "Email already verified? Log in here!",
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
