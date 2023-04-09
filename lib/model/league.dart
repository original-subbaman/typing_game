class League{
  String joinCondition;
  String leagueTitle;
  List<String> players;
  int noOfPlayers;
  String adminId;
  String adminName;

  League({required this.adminId, required this.adminName, required this.leagueTitle, required this.joinCondition, required this.players, this.noOfPlayers = 0});

  League.fromJson(Map<String, dynamic> json)
      : this(
    adminName: json['adminName'] as String,
    adminId: json['adminId'] as String,
    leagueTitle: json['name'] as String,
    joinCondition: json['restriction'] as String,
    players: json['players'] as List<String>,
    noOfPlayers: json['noOfPlayers'] as int,

  );

  Map<String, Object> toJson() {
    return {
      'adminName': adminName,
      'adminId': adminId,
      'leagueTitle': leagueTitle,
      'players': players,
      'noOfPlayers': noOfPlayers,
      'joinCondition': joinCondition,
    };
  }



}