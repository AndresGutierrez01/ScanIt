import 'package:flutter/material.dart';
import 'package:scanit/utilites/AppColors.dart';

class CenterLoad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(backgroundColor: AppColors.aqua));
  }
}
