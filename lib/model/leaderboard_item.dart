
import 'dart:ui';

import 'package:flutter/widgets.dart';

class LeaderboardItem{
  AssetImage userImage;
  String userName;
  String rank;
  Icon upDownIcon;

  LeaderboardItem({this.userImage, this.userName, this.rank, this.upDownIcon});
}