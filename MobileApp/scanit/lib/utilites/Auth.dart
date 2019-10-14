import 'package:firebase_auth/firebase_auth.dart';
import 'package:scanit/utilites/FirestoreTasks.dart';

class Auth{
  static String uid;
  static Future<bool> login({String email, String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      uid = user.uid;
      return true;
    } catch (e) {
      return false;
    }
  }

  static void logout(){
    uid = null;
  }

  static Future<String> signUp({String email, String password, String confirmPassword}) async {

    if(password != confirmPassword){
      return "ERROR_PASSWORD_MATCH";
    }
    try {
      AuthResult auth = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      FirestoreTasks.createUser(auth.user.uid);
      return auth.user.uid;
    } catch (e) {
      return e.code.toString();
    }
  }
  static Future<bool> resetPassword({String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      return false;
    }
  }

  static void sendVerificationEmail() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    try{
      user.sendEmailVerification();
    }catch(e){}
    
  }
  static Future<bool> isEmailVerified() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.isEmailVerified;
  }
}