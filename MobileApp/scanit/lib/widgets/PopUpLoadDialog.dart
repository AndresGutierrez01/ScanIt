import 'package:flutter/material.dart';
import 'package:scanit/utilites/AppColors.dart';
import 'package:scanit/widgets/CenterLoad.dart';

class PopUpLoadDialog extends StatelessWidget {
  PopUpLoadDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: AppColors.background,
        content: Container(
          alignment: Alignment(0, 0),
          height: 100,
          child: CenterLoad(),
        ));
  }
}
