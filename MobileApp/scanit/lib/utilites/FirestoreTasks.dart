import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scanit/utilites/Auth.dart';

class FirestoreTasks {
  static void createUser(String uid) {
    Firestore.instance.collection('users').document(uid).setData({});
  }

  static DocumentReference _user =
      Firestore.instance.collection('users').document(Auth.uid);

  static void createClass(
      String className, String classNumber, String classSection, int color) {
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
      'color': color
    });
  }

  static void deleteClass(String classId) {
    Firestore.instance
        .collection('users')
        .document(Auth.uid)
        .collection('classes')
        .document(classId)
        .delete();
  }

  static void editClass(String classId, String className, String classNumber,
      String classSection, int color) {
    Firestore.instance
        .collection('users')
        .document(Auth.uid)
        .collection('classes')
        .document(classId)
        .updateData({
      'name': className,
      'number': classNumber,
      'section': classSection,
      'color': color
    });
  }

  static void addStudent(String classId, String studentName,
      String studentEmail, String studentId) {
    Firestore.instance
        .collection('users')
        .document(Auth.uid)
        .collection('classes')
        .document(classId)
        .collection('students')
        .document()
        .setData({'name': studentName, 'email': studentEmail, 'id': studentId});
    _incStudentCount(classId);
  }

  static void deleteStudent(String classId, String studentId) {
    _user
        .collection('classes')
        .document(classId)
        .collection('students')
        .document(studentId)
        .delete();
    _decStudentCount(classId);
  }

  static void _incStudentCount(String classId) async{
    DocumentReference classRef = _user.collection('classes').document(classId);
    DocumentSnapshot classSnap= await classRef.get();
    classRef.updateData({
      'studentCount': classSnap.data['studentCount'] += 1
    });
  }

  static void _decStudentCount(String classId) async{
    DocumentReference classRef = _user.collection('classes').document(classId);
    DocumentSnapshot classSnap= await classRef.get();
    classRef.updateData({
      'studentCount': classSnap.data['studentCount'] -= 1
    });
  }


  static void editStudent(String classId, String studentId, String name, String email, String id) {
    _user
        .collection('classes')
        .document(classId)
        .collection('students')
        .document(studentId)
        .updateData({
          'name': name,
          'email':email,
          'id': id
        });
  }
}
