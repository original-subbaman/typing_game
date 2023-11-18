import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thumbing/firebase/auth_exception.dart';
import 'package:thumbing/utility/constants.dart';

class MyFirebaseAuth {
  MyFirebaseAuth(this._auth);

  final FirebaseAuth _auth;

  Stream<User?> get authStateChange => _auth.idTokenChanges();

  String status = "";
  static String? currentUserId = FirebaseAuth.instance.currentUser?.uid;

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    try {
      await _auth.signInWithCredential(credential).then(
          (value) => currentUserId = FirebaseAuth.instance.currentUser?.uid);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw AuthException(kUserNotFound);
        case 'wrong-password':
          throw AuthException(kWrongPassword);
        default:
          throw AuthException(kDefaultError);
      }
    }

    return status;
  }

  Future<String> signInUser(
      {required String email, required String password}) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) =>
              currentUserId = FirebaseAuth.instance.currentUser?.uid);
    } on FirebaseAuthException catch (e) {
      status = e.code;
    }
    return status;
  }

  User? isUserLoggedIn() {
    User? loggedInUser;
    _auth.authStateChanges().listen((User user) {
          loggedInUser = user;
        } as void Function(User? event)?);
    return loggedInUser;
  }

  Future<String> signUpUser(
      {required String email, required String password}) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) =>
              currentUserId = FirebaseAuth.instance.currentUser?.uid);
    } on FirebaseAuthException catch (e) {
      status = e.code;
    }
    return status;
  }

  Future<void> deleteCurrentUser() async {
    await _auth.currentUser?.delete();
  }

  Future<void> signOutUser() async {
    await _auth.signOut();
  }
}
