import 'package:flutter/material.dart';
import 'package:scanit/utilites/AppColors.dart';

class CreateTestForm extends StatelessWidget {
  final TextEditingController nameCtr;
  final VoidCallback onCreate;
  CreateTestForm({
      @required this.nameCtr,
      @required this.onCreate,
    });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.background,
      title: Text(
        'Create Test',
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
                    prefixIcon: Icon(Icons.description, color: AppColors.gray),
                    hintText: "Test Name",
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
            'CREATE',
            style: TextStyle(color: Colors.greenAccent),
          ),
          onPressed: onCreate,
        )
      ],
    );
  }
}
