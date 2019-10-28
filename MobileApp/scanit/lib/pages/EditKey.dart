import 'package:flutter/material.dart';
import 'package:scanit/utilites/AppColors.dart';
import 'package:scanit/utilites/FirestoreTasks.dart';
import 'package:scanit/widgets/FormButton.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

class EditKey extends StatefulWidget {
  final String testId;
  final String classId;
  final String testKey;

  EditKey(
      {@required this.testId, @required this.classId, @required this.testKey});

  @override
  _EditKeyState createState() => _EditKeyState(testKey);
}

class _EditKeyState extends State<EditKey> {
  List _picked;

  _EditKeyState(String testKey) {
    _picked = List<String>.from(testKey.split(''));
  }

  update() {
    FirestoreTasks.updateTestKey(widget.classId, widget.testId, _picked.join());
    Navigator.of(context).pop();
  }

  add() {
    if (_picked.length == 20) {
      return;
    } else {
      setState(() {
        _picked.add('A');
      });
    }
  }

  remove() {
    if (_picked.length == 1) {
      return;
    } else {
      setState(() {
        _picked.removeLast();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Key"),
          centerTitle: true,
        ),
        body: Container(
          color: AppColors.background,
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: ListView.builder(
                      itemCount: _picked.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Text(
                            "${index + 1}.",
                            style: TextStyle(
                              color: AppColors.background,
                                 fontFamily: "Arvo",
                                 fontSize: 24
                            ),
                          ),
                          title: RadioButtonGroup(
                            orientation: GroupedButtonsOrientation.HORIZONTAL,
                            //margin: const EdgeInsets.only(left: 12.0),
                            onSelected: (String selected) => setState(() {
                              _picked[index] = selected;
                            }),
                            labels: <String>["A", "B", "C", "D", "E"],
                            picked: _picked[index],
                            activeColor: AppColors.aqua,
                            itemBuilder: (Radio rb, Text txt, int i) {
                              return Column(
                                children: <Widget>[
                                  txt,
                                  rb,
                                ],
                              );
                            },
                          ),
                        );
                      },
                    )),
              ),
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.remove_circle_outline),
                          iconSize: 50,
                          color: AppColors.white,
                          onPressed: remove,
                        ),
                        IconButton(
                          icon: Icon(Icons.add_circle_outline),
                          iconSize: 50,
                          color: AppColors.white,
                          onPressed: add,
                        )
                      ],
                    ),
                  ),
                  FormButton(
                    text: "Set",
                    onTap: update,
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
