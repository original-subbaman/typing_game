
import 'package:firebase_auth/firebase_auth.dart';
class MyFirebaseAuth {
  static String status = "success";
  static String? currentUserId = FirebaseAuth.instance.currentUser?.uid;

  static Future<String> signInUser({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      ).then((value) => currentUserId = FirebaseAuth.instance.currentUser?.uid);
    } on FirebaseAuthException catch (e) {
      status = e.code;
    }
    return status;
  }

  static User? isUserLoggedIn(){
    User? loggedInUser;
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User user) {
      loggedInUser = user;
    } as void Function(User? event)?);
    return loggedInUser;
  }

  static Future<String> signUpUser({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
      ).then((value) => currentUserId = FirebaseAuth.instance.currentUser?.uid);

    } on FirebaseAuthException catch (e) {
      status = e.code;
    }
    return status;
  }

  static Future<void> deleteCurrentUser()async {
    FirebaseAuth.instance.currentUser?.delete();
  }


  static Future<void> signOutUser()async{
    await FirebaseAuth.instance.signOut();
  }
}