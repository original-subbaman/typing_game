import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thumbing/firebase/firebase_authentication.dart';
import 'package:thumbing/firebase/firebase_constants.dart';

import '../model/league.dart';

class MyCloudFirestore {
  static final db = FirebaseFirestore.instance;
  static final CollectionReference _users = db.collection(kUserCollection);
  static String currentUser;

  static Future<String> getCurrentUserName() async {
    String currentUser;
    await _users
        .doc(MyFirebaseAuth.currentUserId)
        .get()
        .then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> user = snapshot.data() as Map<String, dynamic>;
        currentUser = user['user_name'];
      }
    });
    print(currentUser);
    return currentUser;
  }

  static Future<String> addUser(
      {String uid,
      String username,
      String fullName,
      String email,
      int acc = 0,
      int wpm = 0}) async {
    String status;
    User user = await _users.doc(uid).set({
      'uid': uid,
      'user_name': username,
      'full_name': fullName,
      'email': email,
      'acc': acc,
      'wpm': wpm,
    }).then((value) {
      print('User Added');
      status = "success";
    }).catchError((error) {
      print('Error adding user: $error');
      status = error;
    });

    return status;
  }

  static Future<String> addLeague({League league}) async {
    final leagueRef =
        FirebaseFirestore.instance.collection('leagues').withConverter<League>(
              fromFirestore: (snapshot, _) => League.fromJson(snapshot.data()),
              toFirestore: (movie, _) => movie.toJson(),
            );

    await leagueRef.add(
      league,
    );
  }
  static getBestScore() async {
    final user = _users.doc(MyFirebaseAuth.currentUserId);
    final score = [0, 0]; //0 index = accuracy, 1 index = wpm
    await user.get().then((snapshot){
      if(snapshot.exists){
        Map data = snapshot.data();
        score[0] = data['acc'];
        score[1] = data['wpm'];
      }
    });
    return score;
  }
  static updateUserBestScore({int acc, int wpm}) async {
      final user = _users.doc(MyFirebaseAuth.currentUserId);
      final bestScore = await getBestScore();

      if(acc > bestScore[0]){
        if(wpm > bestScore[1]){
          user.update(
              {
                "acc": acc,
                "wpm": wpm,
              }
          ).then(
                (value) => print("User best score updated!"),
            onError: (e) => print("Error updating score!"),
          );
        }else{
          user.update({
            "acc": acc,
          }).then(
              (value) => print("User best accuracy updated"),
            onError: (e) => print("Error updating acc"),
          );
        }
      }else if(wpm > bestScore[1]){
        user.update({
          "wpm": wpm,
        }).then(
            (value) => print("User best wpm updated"),
          onError: (e) => print("Error updating wpm"),
        );
      }

  }
}
