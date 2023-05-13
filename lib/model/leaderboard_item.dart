
import 'dart:ui';

import 'package:flutter/widgets.dart';

class LeaderboardItem{
  String userName;
  int rank;
  int leagueScore;
  int wpm;
  int acc;

  LeaderboardItem({required this.userName,
    required this.leagueScore, required this.rank, required this.wpm
  , required this.acc} );
}