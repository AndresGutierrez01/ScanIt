import 'package:flutter/material.dart';
import 'package:scanit/utilites/AppColors.dart';

class CenterLoad extends StatelessWidget {
  final String error;
  CenterLoad({this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(backgroundColor: AppColors.aqua));
  }
}
