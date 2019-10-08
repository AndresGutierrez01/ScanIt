import 'package:flutter/material.dart';
import 'package:scanit/utilites/AppColors.dart';

class MainBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("SCANIT", style: TextStyle(fontSize: 18, color: AppColors.gray));
  }
}
