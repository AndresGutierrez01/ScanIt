import 'package:flutter/material.dart';
import 'package:scanit/utilites/AppColors.dart';

class MainBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(25),
            width: 70,
            height: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  colors: AppColors.mainGradiant,
                  begin: FractionalOffset.centerLeft,
                  end: FractionalOffset.centerRight,
                  stops: [0.0, 1.0],
                  tileMode: TileMode.repeated,
                )),
          ),
          Text("SCANIT", style: TextStyle(fontSize: 18, color: AppColors.gray)),
        ],
      ),
    );
  }
}
