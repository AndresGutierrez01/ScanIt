import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scanit/utilites/Auth.dart';

class FirestoreStreams {
  static DocumentReference _user =
      Firestore.instance.collection('users').document(Auth.uid);

  static Stream<QuerySnapshot> classesStream() {
    return _user.collection('classes').orderBy('name').snapshots();
  }

  static Stream<QuerySnapshot> studentsStream(String classId) {
    return _user
        .collection('classes')
        .document(classId)
        .collection('students')
        .orderBy('name')
        .snapshots();
  }
}
