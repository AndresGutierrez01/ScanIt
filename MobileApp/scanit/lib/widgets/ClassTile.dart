import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scanit/utilites/AppColors.dart';

class ClassTile extends StatelessWidget {
  final Map classData;
  final String classId;
  final Function(String,String) onTap;
  final Function(String) onDelete;
  final Function(String, Map) onEdit;
  ClassTile({
    @required this.classData,
    @required this.classId,
    @required this.onTap,
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
          onTap:() => onEdit(classId, classData),
        ),
        IconSlideAction(
          caption: "Delete",
          color: Colors.redAccent,
          icon: Icons.delete,
          onTap:() => onDelete(classId),
        )
      ],
      child: GestureDetector(
        onTap: () => onTap(classData['name'], classId),
        child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color(classData['color']),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10))),
                    width: 1.0 / 0.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(classData['name'],
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white)),
                            Text(classData['number'].toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Arvo',
                                    color: AppColors.background))
                          ],
                        ),
                        Text("section: ${classData['section']}",
                        style: TextStyle(color: AppColors.white),)
                      ],
                    )
                ),
                Padding(padding: EdgeInsets.all(10),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text("Tests",
                        style: TextStyle(
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                        Text("${classData['testCount']}",
                        style: TextStyle(
                          fontFamily: "Arvo",
                          fontSize: 52,
                          color: AppColors.background
                        ),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text("Students",
                        style: TextStyle(
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.bold,
                        ),),
                        Text("${classData['studentCount']}",
                        style: TextStyle(
                          fontFamily: "Arvo",
                          fontSize: 52,
                          color: AppColors.background
                        )),
                      ],
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.all(10),)
              ],
            )
        ),
      ),
    );
  }
}
