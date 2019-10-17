import 'package:flutter/material.dart';
import 'package:scanit/utilites/AppColors.dart';

class AddStudentForm extends StatelessWidget {
  final TextEditingController nameCtr;
  final TextEditingController idCtr;
  final TextEditingController emailCtr;
  final VoidCallback onAdd;
  AddStudentForm(
      {@required this.nameCtr,
      @required this.idCtr,
      @required this.emailCtr,
      @required this.onAdd
      });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.background,
      title: Text(
        'Add Student',
        style: TextStyle(color: AppColors.white),
      ),
      content: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: <Widget>[
              TextField(
                controller: nameCtr,
                style: TextStyle(color: AppColors.aqua),
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_outline, color: AppColors.gray),
                    hintText: "Student Name",
                    hintStyle: TextStyle(color: AppColors.aqua),
                    border: InputBorder.none),
              ),
              Divider(
                color: AppColors.white,
                height: 0,
              ),
              TextField(
                controller: emailCtr,
                style: TextStyle(color: AppColors.aqua),
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: AppColors.gray),
                    hintText: "Student Email",
                    hintStyle: TextStyle(color: AppColors.aqua),
                    border: InputBorder.none),
              ),
              Divider(
                color: AppColors.white,
                height: 0,
              ),
              TextField(
                controller: idCtr,
                style: TextStyle(color: AppColors.aqua),
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.fingerprint, color: AppColors.gray),
                    hintText: "Student ID",
                    hintStyle: TextStyle(color: AppColors.aqua),
                    border: InputBorder.none),
              ),
              Divider(
                color: AppColors.white,
                height: 0,
              ),
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
            'ADD',
            style: TextStyle(color: Colors.greenAccent),
          ),
          onPressed: onAdd,
        )
      ],
    );
  }
}
