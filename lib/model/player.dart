import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thumbing/firebase/firebase_constants.dart';

class Player {
  //uid, fullname, email, league_score, user_name, acc, wpm
  final String? uid;
  final String fullName;
  final String email;
  final int leagueScore;
  final String userName;
  final int acc;
  final int wpm;
  final int bestRank;

  Player( {required this.uid, required this.fullName, required this.email, required this.leagueScore,
      required this.userName, required this.acc, required this.wpm, required this.bestRank});

  factory Player.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions options,){
   final data = snapshot.data();
   return Player(
     uid: data!['$UID'],
     fullName: data['$FULL_NAME'],
     email: data['$EMAIL'],
     leagueScore: data['$LEAGUE_SCORE'],
     userName: data['$USER_NAME'],
     acc: data['$ACC'],
     wpm: data['$WPM'],
     bestRank: data['$BEST_RANK'],
   );
  }

  Map<String, dynamic> toFirestore(){
    return {
      '$UID': uid,
      '$FULL_NAME': fullName,
      '$EMAIL': email,
      '$LEAGUE_SCORE': leagueScore,
      '$USER_NAME': userName,
      '$ACC': acc,
      '$WPM': wpm,
      '$BEST_RANK': bestRank,
    };
  }


}