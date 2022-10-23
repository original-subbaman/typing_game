import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thumbing/firebase/firebase_authentication.dart';
import 'package:thumbing/firebase/firebase_constants.dart';
import 'package:thumbing/model/leaderboard_item.dart';
import 'package:thumbing/model/user.dart';

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
    await _users.doc(uid).set({
      UserProperties.UID: uid,
      UserProperties.USER_NAME: username,
      UserProperties.FULL_NAME: fullName,
      UserProperties.EMAIL: email,
      UserProperties.ACC: acc,
      UserProperties.WPM: wpm,
      UserProperties.LEAGUE_SCORE: 0,
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
                UserProperties.ACC: acc,
                UserProperties.WPM: wpm,
              }
          ).then(
                (value) => print("User best score updated!"),
            onError: (e) => print("Error updating score!"),
          );
        }else{
          user.update({
            UserProperties.ACC: acc,
          }).then(
              (value) => print("User best accuracy updated"),
            onError: (e) => print("Error updating acc"),
          );
        }
      }else if(wpm > bestScore[1]){
        user.update({
          UserProperties.WPM: wpm,
        }).then(
            (value) => print("User best wpm updated"),
          onError: (e) => print("Error updating wpm"),
        );
      }

  }

  static updateLeagueScore({int leagueScore}) async {
    final user = _users.doc(MyFirebaseAuth.currentUserId);
    await user.get().then((snapshot){
      if(snapshot.exists){
        final Map data = snapshot.data();
        if(leagueScore > data['league_score']){
          user.update({"league_score": leagueScore}).then(
              (value) => print("User league score updated"),
            onError: (e) => print("Error updating league score"),
          );
        }
      }
    });
  }

  static getLeaderboard() async{
    final topTenPlayersList = [];
    int rank = 1;
    db.collection(kLeagueCollection)
        .orderBy("league_score", descending: true)
        .limit(10).get().then((snapshot) => {
          snapshot.docs.forEach((doc) {
            final player = doc.data();
            topTenPlayersList.add(new LeaderboardItem(userName: player[LEAGUE_SCORE], leagueScore: player[LEAGUE_SCORE], rank: rank));
            rank++;
         })
    });

    return topTenPlayersList;

  }
}
