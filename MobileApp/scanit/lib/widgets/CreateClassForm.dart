import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/block_picker.dart';
import 'package:scanit/utilites/AppColors.dart';

class CreateClassForm extends StatelessWidget {
  final TextEditingController nameCtr;
  final TextEditingController numberCtr;
  final TextEditingController sectionCtr;
  final VoidCallback onCreate;
  final Function(Color) onColor;
  CreateClassForm(
      {@required this.nameCtr,
      @required this.numberCtr,
      @required this.sectionCtr,
      @required this.onCreate,
      @required this.onColor});

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
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
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
              Divider(
                color: AppColors.white,
                height: 0,
              ),
              TextField(
                controller: numberCtr,
                style: TextStyle(color: AppColors.aqua),
                decoration: InputDecoration(
                    prefixIcon:
                        Icon(Icons.confirmation_number, color: AppColors.gray),
                    hintText: "Class Number",
                    hintStyle: TextStyle(color: AppColors.aqua),
                    border: InputBorder.none),
              ),
              Divider(
                color: AppColors.white,
                height: 0,
              ),
              TextField(
                controller: sectionCtr,
                style: TextStyle(color: AppColors.aqua),
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.merge_type, color: AppColors.gray),
                    hintText: "Class Section",
                    hintStyle: TextStyle(color: AppColors.aqua),
                    border: InputBorder.none),
              ),
              Divider(
                color: AppColors.white,
                height: 0,
              ),
              Container(
                height: 120,
                margin: EdgeInsets.all(20),
                child: BlockPicker(
                  pickerColor: AppColors.aqua,
                  onColorChanged: onColor,
                  availableColors: [
                    AppColors.aqua,
                    Colors.deepOrange,
                    Colors.deepPurple,
                    Colors.green,
                    Colors.redAccent,
                    Colors.blueAccent,
                    Colors.pinkAccent,
                    Colors.black,
                  ],
                ),
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
