import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:thumbing/firebase/firebase_authentication.dart';
import 'package:thumbing/firebase/firebase_constants.dart';
import 'package:thumbing/model/leaderboard_item.dart';
import 'package:thumbing/model/player.dart';

import '../model/league.dart';
import '../utility/constants.dart';

class MyCloudFirestore {
  static final db = FirebaseFirestore.instance;
  static final CollectionReference _users = db.collection(kUserCollection);
  static final CollectionReference _league = db.collection(kLeagueCollection);
  static String? currentUser;
  static int? currentRank;

  static Future<String?> getCurrentUserName() async {
    await _users
        .doc(MyFirebaseAuth.currentUserId)
        .get()
        .then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> user = snapshot.data() as Map<String, dynamic>;
        currentUser = user['user_name'];
      }
    });
    return currentUser;
  }

  static Future<Player?> getUser() async {
    Player? player;
    await _users.doc(MyFirebaseAuth.currentUserId).get().then((value) {
      if (value.exists) {
        Map<String, dynamic> data = value.data() as Map<String, dynamic>;
        player = new Player(
          uid: data[UID],
          fullName: data[FULL_NAME],
          email: data[EMAIL],
          leagueScore: data[LEAGUE_SCORE],
          userName: data[USER_NAME],
          acc: data[ACC],
          wpm: data[WPM],
          bestRank: data[BEST_RANK].toString(),
        );
      }
    });
    return player;
  }

  static DocumentReference<Player> getUserDocumentReference(
      {required String? uid}) {
    return _users
        .withConverter(
            fromFirestore: (snapshot, options) =>
                Player.fromFirestore(snapshot, options!),
            toFirestore: (Player player, options) => player.toFirestore())
        .doc(uid);
  }

  static void addLeague({required League league}) async {
    final leagueRef =
        FirebaseFirestore.instance.collection('leagues').withConverter<League>(
              fromFirestore: (snapshot, _) => League.fromJson(snapshot.data()!),
              toFirestore: (movie, _) => movie.toJson(),
            );

    await leagueRef.add(
      league,
    );
  }

  static getBestScore() async {
    final user = _users.doc(MyFirebaseAuth.currentUserId);
    final score = [0, 0]; //0 index = accuracy, 1 index = wpm
    await user.get().then((snapshot) {
      if (snapshot.exists) {
        Map data = snapshot.data() as Map;
        score[0] = data['acc'];
        score[1] = data['wpm'];
      }
    });
    return score;
  }

  static updateUserBestScore({required int acc, required int wpm}) async {
    final user = _users.doc(MyFirebaseAuth.currentUserId);
    final bestScore = await getBestScore();

    if (acc > bestScore[0]) {
      if (wpm > bestScore[1]) {
        user.update({
          ACC: acc,
          WPM: wpm,
        }).then(
          (value) => print("User best score updated!"),
          onError: (e) => print("Error updating score!"),
        );
      } else {
        user.update({
          ACC: acc,
        }).then(
          (value) => print("User best accuracy updated"),
          onError: (e) => print("Error updating acc"),
        );
      }
    } else if (wpm > bestScore[1]) {
      user.update({
        WPM: wpm,
      }).then(
        (value) => print("User best wpm updated"),
        onError: (e) => print("Error updating wpm"),
      );
    }
  }

  static updateLeagueScoreInUsers({required int leagueScore}) async {
    final user = _users.doc(MyFirebaseAuth.currentUserId);
    await user.get().then((snapshot) {
      if (snapshot.exists) {
        final Map data = snapshot.data() as Map;
        if (leagueScore > data['league_score']) {
          user.update({"league_score": leagueScore}).then(
            (value) => print("User league score updated"),
            onError: (e) => print("Error updating league score"),
          );
        }
      }
    });
  }

  static updateLeagueScoreInLeagueTable({required int leagueScore}) async {
    final league = _league.doc(MyFirebaseAuth.currentUserId);
    await league.get().then((snapshot) {
      if (snapshot.exists) {
        final Map data = snapshot.data() as Map;
        if (leagueScore > data['league_score']) {
          league.update({"league_score": leagueScore}).then(
              (value) => print("User league score updated in league table"),
              onError: (e) =>
                  print("Error updating league score in league table"));
        }
      }
    });
  }

  static addNewUserToLeague({required Player newPlayer}) async {
    final player = {
      'user_name': newPlayer.userName,
      'league_score': newPlayer.leagueScore,
    };
    await _league
        .doc(newPlayer.uid)
        .set(player)
        .then((value) => print("Successfully added user to league"));
  }

  static getLeaderboard() async {
    final topTenPlayersList = [];
    int rank = 1;
    await db
        .collection(kLeagueCollection)
        .orderBy("league_score", descending: true)
        .get()
        .then((snapshot) => {
              snapshot.docs.forEach((doc) {
                final player = doc.data();
                final String userName = player["user_name"];
                final int leagueScore = player["league_score"];
                topTenPlayersList.add(new LeaderboardItem(
                    userName: userName, leagueScore: leagueScore, rank: rank));
                rank++;
              })
            });
    return topTenPlayersList;
  }

  static Future<int?> getUserRank() async {
    return await getLeaderboard().then((players) {
      for (var player in players) {
        if (player.userName == MyCloudFirestore.currentUser) {
          return player.rank;
        }

        print("${player.userName} == ${MyCloudFirestore.currentUser}");
      }
    });
  }
}
