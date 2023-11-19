import 'package:thumbing/firebase/firebase_constants.dart';

class LeaderboardItem {
  String userName;
  int rank;
  int leagueScore;
  int wpm;
  int acc;

  LeaderboardItem(
      {required this.userName,
      required this.leagueScore,
      required this.rank,
      required this.wpm,
      required this.acc});

  factory LeaderboardItem.fromFirestore(Map<String, dynamic> snapshot){
    return LeaderboardItem(
      userName: snapshot!['$USER_NAME'],
      leagueScore: snapshot['$LEAGUE_SCORE'],
      rank: 0,
      acc: snapshot['$ACC'],
      wpm: snapshot['$WPM'],
    );
  }




}
