import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thumbing/firebase/firebase_authentication.dart';
import 'package:thumbing/firebase/firebase_constants.dart';
import 'package:thumbing/model/leaderboard_item.dart';
import 'package:thumbing/model/player.dart';

import '../model/league.dart';

class MyCloudFirestore {

  FirebaseFirestore _firestore;
  MyCloudFirestore(this._firestore);
  String? currentUser;
  int? currentRank;

  Future<String?> createNewPlayer(uid, newPlayer) async{
    final userRef = getUserDocumentReference(
        uid: uid);

    userRef
        .set(newPlayer)
    /*.onError(
            (error, stackTrace) => //showCreateUserException(error as String))*/
        .then((value) {
      addNewUserToLeague(newPlayer: newPlayer);
      //TODO: Navigate to Wrapper Page
    });

  }

  Future<String?> getCurrentUserName() async {
    await _firestore.collection(kUserCollection)
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

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUser(uid) {
    return _firestore.collection(kUserCollection).doc(uid).snapshots();
  }

  DocumentReference<Player> getUserDocumentReference(
      {required String? uid}) {
    return _firestore.collection(kUserCollection)
        .withConverter(
            fromFirestore: (snapshot, options) =>
                Player.fromFirestore(snapshot, options!),
            toFirestore: (Player player, options) => player.toFirestore())
        .doc(uid);
  }

  void addLeague({required League league}) async {
    final leagueRef =
        _firestore.collection(kLeagueCollection).withConverter<League>(
              fromFirestore: (snapshot, _) => League.fromJson(snapshot.data()!),
              toFirestore: (movie, _) => movie.toJson(),
            );
    await leagueRef.add(
      league,
    );
  }

  getBestScore() async {
    final user = _firestore.collection(kUserCollection).doc(MyFirebaseAuth.currentUserId);
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

  updateUserBestScore({required int acc, required int wpm}) async {
    final user = _firestore.collection(kUserCollection).doc(MyFirebaseAuth.currentUserId);
    final bestScore = await getBestScore();

    if (acc > bestScore[0]) {
      if (wpm > bestScore[1]) {
        user.update({
          ACC: acc,
          WPM: wpm,
        }).then(
          (value) => print("User best score updated!"),
          onError: (e) => print("Error updating score! ${e.toString()}"),
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

  updateLeagueScoreInUsers({required int leagueScore}) async {
    final user = _firestore.collection(kUserCollection).doc(MyFirebaseAuth.currentUserId);
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

  updateLeagueScoreInLeagueTable({required int leagueScore, required int acc, required int wpm}) async {
    final league = _firestore.collection(kLeagueCollection).doc(MyFirebaseAuth.currentUserId);
    await league.get().then((snapshot) {
      if (snapshot.exists) {
        final Map data = snapshot.data() as Map;
        if (leagueScore > data['league_score']) {
          league.update({
            "league_score": leagueScore,
            "acc": acc,
            "wpm": wpm,
          }).then(
              (value) => print("User league score updated in league table"),
              onError: (e) =>
                  print("Error updating league score in league table"));
        }
      }
    });
  }

  addNewUserToLeague({required Player newPlayer}) async {
    final player = {
      'user_name': newPlayer.userName,
      'league_score': newPlayer.leagueScore,
      'acc': 0,
      'wpm': 0,
      'best_rank': newPlayer.bestRank,
    };
    await _firestore.collection(kLeagueCollection)
        .doc(newPlayer.uid)
        .set(player)
        .then((value) => print("Successfully added user to league"));
  }

  getLeaderboard() async {
    final topTenPlayersList = [];
    int rank = 1;
    await _firestore
        .collection(kLeagueCollection)
        .orderBy("league_score", descending: true)
        .get()
        .then((snapshot) => {
              snapshot.docs.forEach((doc) {
                final player = doc.data();
                final String userName = player["user_name"];
                final int leagueScore = player["league_score"];
                final int wpm = player["wpm"];
                final int acc = player["acc"];
                topTenPlayersList.add(new LeaderboardItem(
                    userName: userName,
                    leagueScore: leagueScore,
                    rank: rank,
                    acc: acc,
                    wpm: wpm,
                ));
                rank++;
              })
            });
    return topTenPlayersList;
  }

  Future<int?> getUserRank() async {
    return await getLeaderboard().then((players) {
      for (var player in players) {
        if (player.userName == currentUser) {
          return player.rank;
        }
      }
    });
  }
}
