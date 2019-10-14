import 'package:flutter/material.dart';
import 'package:scanit/pages/Login.dart';
import 'package:scanit/utilites/AppColors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: AppColors.aqua,
        fontFamily: 'Montserrat',
      ),
      home: Login(),
    );
  }
}

