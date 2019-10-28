import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scanit/utilites/AppColors.dart';

class TestTile extends StatelessWidget {
  final Map testData;
  final String testId;
  final Function(String) onDelete;
  final Function(String, Map) onEdit;
  final Function(String, String) onTap;

  TestTile(
      {@required this.testData,
      @required this.testId,
      @required this.onDelete,
      @required this.onEdit,
      @required this.onTap
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
          onTap: () => onEdit(testId, testData),
        ),
        IconSlideAction(
          caption: "Delete",
          color: Colors.redAccent,
          icon: Icons.delete,
          onTap: () => onDelete(testId),
        )
      ],
      child: GestureDetector(
        onTap: () => onTap(testId, testData['name']),
        child: Container(
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                testData['name'],
                style: TextStyle(
                    color: AppColors.background,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        "AVERAGE",
                        style: TextStyle(color: AppColors.primaryBlue),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      Text(
                        "${testData['average']}",
                        style: TextStyle(
                            color: AppColors.background,
                            fontFamily: 'Arvo',
                            fontSize: 22),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "MEDIAN",
                        style: TextStyle(color: AppColors.primaryBlue),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      Text(
                        "${testData['average']}",
                        style: TextStyle(
                            color: AppColors.background,
                            fontFamily: 'Arvo',
                            fontSize: 22),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "HIGH",
                        style: TextStyle(color: AppColors.primaryBlue),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      Text(
                        "${testData['average']}",
                        style: TextStyle(
                            color: AppColors.background,
                            fontFamily: 'Arvo',
                            fontSize: 22),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "LOW",
                        style: TextStyle(color: AppColors.primaryBlue),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      Text(
                        "${testData['average']}",
                        style: TextStyle(
                            color: AppColors.background,
                            fontFamily: 'Arvo',
                            fontSize: 22),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
