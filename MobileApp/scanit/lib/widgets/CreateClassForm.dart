import 'package:flutter/material.dart';
import 'package:scanit/utilites/AppColors.dart';

class CreateClassForm extends StatelessWidget {
  final TextEditingController nameCtr;
  final TextEditingController numberCtr;
  final TextEditingController sectionCtr;
  final VoidCallback onCreate;
  CreateClassForm({
    @required this.nameCtr,
    @required this.numberCtr,
    @required this.sectionCtr,
    @required this.onCreate
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.background,
      title: Text(
        'Create Class',
        style: TextStyle(color: AppColors.white),
      ),
      content: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            children: <Widget>[
              TextField(
                controller: nameCtr,
                style: TextStyle(color: AppColors.aqua),
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.class_, color: AppColors.gray),
                    hintText: "Class Name",
                    hintStyle: TextStyle(color: AppColors.aqua),
                    border: InputBorder.none),
              ),
              Divider(color: AppColors.white, height: 0,),
              TextField(
                controller: numberCtr,
                style: TextStyle(color: AppColors.aqua),
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.confirmation_number, color: AppColors.gray),
                    hintText: "Class Number",
                    hintStyle: TextStyle(color: AppColors.aqua),
                    border: InputBorder.none),
              ),
              Divider(color: AppColors.white, height: 0,),
              TextField(
                controller: sectionCtr,
                style: TextStyle(color: AppColors.aqua),
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.merge_type, color: AppColors.gray),
                    hintText: "Class Section",
                    hintStyle: TextStyle(color: AppColors.aqua),
                    border: InputBorder.none),
              ),
              Divider(color: AppColors.white, height: 0,),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: const Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text(
            'CREATE',
            style: TextStyle(color: AppColors.aqua),
          ),
          onPressed: onCreate,
        )
      ],
    );
  }
}
