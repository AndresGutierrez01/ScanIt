import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scanit/utilites/AppColors.dart';

class StudentTile extends StatelessWidget {
  final Map studentData;
  final String studentId;
  final Function(String) onDelete;
  final Function(String, Map) onEdit;

  StudentTile({
    @required this.studentData,
    @required this.studentId,
    @required this.onDelete,
    @required this.onEdit
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: "Edit",
          color: Colors.orangeAccent,
          icon: Icons.edit,
          onTap: () => onEdit(studentId, studentData),
        ),
        IconSlideAction(
          caption: "Delete",
          color: Colors.redAccent,
          icon: Icons.delete,
          onTap: () => onDelete(studentId),
        )
      ],
      child: GestureDetector(
        onTap: () => {},
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                studentData['name'],
                style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(studentData['email'],
                  style: TextStyle(color: AppColors.aqua),
                  ),
                  Text(
                    studentData['id'],
                    style:
                        TextStyle(color: AppColors.white, fontFamily: 'Arvo'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
