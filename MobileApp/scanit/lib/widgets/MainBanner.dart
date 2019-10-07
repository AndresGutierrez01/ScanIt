import 'package:flutter/material.dart';
import '../utilites/AppColors.dart';

class MainBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30),
      decoration: BoxDecoration(
          color: AppColors.blue, borderRadius: BorderRadius.circular(5)),
      child: Text("SCANIT",
          style: TextStyle(
              color: AppColors.yellow,
              fontSize: 52,
              fontFamily: "Mansalva",
              fontWeight: FontWeight.bold)),
    );
  }
}
