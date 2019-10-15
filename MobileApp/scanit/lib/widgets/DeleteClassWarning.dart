import 'package:flutter/material.dart';
import 'package:scanit/utilites/AppColors.dart';

class DeleteClassWarning extends StatelessWidget {

  final Function(String) onDelete;
  final String classId;
  DeleteClassWarning({
    @required this.onDelete,
    @required this.classId
  });
 
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.background,
      title: Text(
        'Delete Class?',
        style: TextStyle(color: AppColors.white),
      ),
      content: Text("After deleting a class, all test and students in the class will be deleted.",
      style: TextStyle(color: AppColors.white),),
      actions: <Widget>[
        FlatButton(
          child: const Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text(
            'DELETE',
            style: TextStyle(color: Colors.redAccent),
          ),
          onPressed:()=> onDelete(classId),
        )
      ],
    );
  }
}
