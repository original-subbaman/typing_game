import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thumbing/firebase/firebase_constants.dart';
import 'package:thumbing/firebase/firebase_firestore.dart';
import 'package:thumbing/model/leaderboard_item.dart';
import 'package:thumbing/providers/firestore_provider.dart';
import 'package:thumbing/screens/leaderboard_screen.dart';
import 'package:thumbing/utility/constants.dart';

import '../utility/colors.dart';

final leagueProvider = StateProvider((ref) => []);

class Leaderboard extends ConsumerStatefulWidget {
  final bool showExpand;
  final borderRadius;

  Leaderboard(this.showExpand, this.borderRadius);

  @override
  ConsumerState<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends ConsumerState<Leaderboard> {
  var trailingItemTextStyle = kCardTextStyle.copyWith(
      fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);

  TrailingText(data, textStyle) {
    return Text(
      data.toString(),
      style: textStyle,
    );
  }

  HeaderText(header) {
    return Text(
      header,
      style: trailingItemTextStyle.copyWith(color: Colors.deepPurpleAccent),
    );
  }

  /*
  * For each player rank is set has index in which they appear in the array + 1 (+1 because 0 index)
  * */
  _setPlayerRank(List<LeaderboardItem> leaderboard) {
    int rank = 1;
    for(var player in leaderboard) {
      player.rank = rank;
      rank += 1;
    }
    return leaderboard;
  }


  refreshLeagueData() async {
    // await MyCloudFirestore.getLeaderboard().then((value) {
    //   ref.read(leagueProvider.notifier).update((state) => value);
    //   _setPlayerRank();
    // });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final leagueData = ref.watch(leaderboardProvider);
    leagueData.when(
        data: (data) => print("data is: $data"),
        error: (error, _) => print(error),
        loading: () => print("loading..."));
    return Material(
      elevation: 10.0,
      color: kLightBlueAccent,
      borderRadius: widget.borderRadius,
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 15.0, right: 15.0, top: 12.0, bottom: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Leaderboard',
                    textAlign: TextAlign.left,
                    style: kCardTextStyle.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          refreshLeagueData();
                        },
                        icon: Icon(Icons.refresh, size: 25),
                        color: Colors.white,
                      ),
                      Visibility(
                        visible: widget.showExpand,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, LeaderboardScreen.kLeaderboardScreen);
                          },
                          icon: Icon(
                            Icons.north_east_rounded,
                            size: 25,
                          ),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Expanded(
                child: leagueData.when(
                    data: (data) {
                      final leaderboard = _setPlayerRank(data);
                      return ListView.builder(
                        itemCount: leaderboard.length,
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemBuilder: (_, index) {
                          var user = leaderboard[index];
                          return ListTile(
                            leading:
                                TrailingText(user.rank, trailingItemTextStyle),
                            title: Text(
                              user.userName,
                              style: kCardTextStyle,
                            ),
                            trailing: Wrap(
                              children: <Widget>[
                                TrailingText(
                                    "${user.wpm} w/m", trailingItemTextStyle),
                                TrailingText(
                                    "${user.acc} %", trailingItemTextStyle),
                              ],
                              spacing: 20.0,
                            ),
                          );
                        },
                      );
                    },
                    error: (error, _) => Center(
                          child: Text("Error: $error"),
                        ),
                    loading: () => CircularProgressIndicator()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
