import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ClassTile extends StatelessWidget {
  final Map classData;
  final String classId;
  ClassTile({
    @required this.classData,
    @required this.classId,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: "Delete",
          color: Colors.redAccent,
          icon: Icons.delete,
          //onTap:() => onDelete(classId),
        )
      ],
      child: GestureDetector(
       // onTap: () => onTap(classId),
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          child: ListTile(
            title: Text(
              classData['name'],
              style: TextStyle(fontSize: 14),
            ),
            leading: Text(
              classData["number"].toString(),
              style: TextStyle(
                //fontFamily: "Arvo",
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.blue
              ),
            ),
          ),
        ),
      ),
    );
  }
}
