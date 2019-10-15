import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scanit/utilites/Auth.dart';

class FirestoreTasks {
  static void createUser(String uid) {
    Firestore.instance.collection('users').document(uid).setData({});
  }

  static void createClass(
      String className, String classNumber, String classSection) {
    Firestore.instance
        .collection('users')
        .document(Auth.uid)
        .collection('classes')
        .document()
        .setData({
          'name': className,
          'number': classNumber,
          'section': classSection,
          'testCount': 0,
          'studentCount': 0, 
        });
  }
}
