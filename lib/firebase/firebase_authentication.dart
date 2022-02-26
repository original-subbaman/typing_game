import 'package:firebase_auth/firebase_auth.dart';
class MyFirebaseAuthentication {
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

  static User isUserLoggedIn(){
    User loggedInUser;
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
      loggedInUser = user;
    });
    return loggedInUser;
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

  static Future<void> deleteCurrentUser(){
    FirebaseAuth.instance.currentUser.delete();
  }


  static Future<void> signOutUser()async{
    await FirebaseAuth.instance.signOut();
  }
}