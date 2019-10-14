import 'package:cloud_firestore/cloud_firestore.dart';

class DBCourse{
  String name;
  //String code;
  int capacity;
  DocumentReference courseRef;
  CollectionReference topicRef;
  String uid;

  DBCourse(DocumentSnapshot course){
    courseRef = course.reference;
    uid = course.documentID;
    name = course.data["name"];
  }

  String getCourseID(DBCourse x){
    return x.uid;
  }
}