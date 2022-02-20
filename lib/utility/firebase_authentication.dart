import 'package:firebase_auth/firebase_auth.dart';
class FirebaseAuthentication {
  static String status = "success";

  static Future<String> signInUser({String email, String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      status = e.code;
    }
    return status;
  }
  static Future<String> signUpUser({String email, String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
      ) ;
    } on FirebaseAuthException catch (e) {
      status = e.code;
    }
    return status;
  }

  static Future<void> signOutUser()async{
    await FirebaseAuth.instance.signOut();
  }
}