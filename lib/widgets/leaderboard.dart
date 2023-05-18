import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thumbing/firebase/firebase_firestore.dart';
import 'package:thumbing/model/leaderboard_item.dart';
import 'package:thumbing/screens/leaderboard_screen.dart';
import 'package:thumbing/utility/constants.dart';

class Leaderboard extends StatefulWidget {
  final bool showExpand;
  final borderRadius;

  Leaderboard(this.showExpand, this.borderRadius);

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  var items = [];

  var trailingItemTextStyle = kCardTextStyle.copyWith(
      fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);

  TrailingText(data) {
    return Text(
      data.toString(),
      style: trailingItemTextStyle,
    );
  }

  HeaderText(header){
    return Text(
      header,
      style: trailingItemTextStyle.copyWith(color: Colors.deepPurpleAccent),
    );
  }

  setPlayerRank() {
    for (var i = 1; i < items.length; i++) {
      if (MyCloudFirestore.currentUser == items[i].userName) {
        MyCloudFirestore.currentRank = i + 1;
      }
    }
  }

  setLeagueData() async {
    await MyCloudFirestore.getLeaderboard().then((value) {
      setState(() {
         items = items + value;
         setPlayerRank();
      });
    });
  }

  refreshLeagueData() async {
    await MyCloudFirestore.getLeaderboard().then((value) {
      setState(() {
        items.removeRange(1, items.length);
        items = items + value;
        setPlayerRank();
      });
    });
  }

  @override
  void initState() {
    //Need to add one dummy item to the items list at the index 0 as a place holder for the header
    //header is Rank, Player, WPM, ACC
    items.add(LeaderboardItem(userName: "", leagueScore: 0, rank: 0, wpm: 0, acc: 0));
    setLeagueData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                child: ListView.builder(
                  itemCount: items.length,
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemBuilder: (_, index) {
                    var user = items[index];
                    if(index == 0){
                      return ListTile(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2, color: Colors.deepPurpleAccent),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        selectedTileColor: Colors.white,
                        selected: true,
                        leading: HeaderText("Rank"),
                        title: HeaderText("Player"),
                        trailing: Wrap(
                          children: [
                            HeaderText("wpm"),
                            HeaderText("acc"),
                          ],
                          spacing: 8.0,
                        ),
                      );
                    }else{
                      return ListTile(
                        leading: TrailingText(user.rank),
                        title: Text(
                          user.userName,
                          style: kCardTextStyle,
                        ),
                        trailing: Wrap(
                          children: <Widget>[
                            TrailingText(user.wpm),
                            TrailingText(user.acc),
                          ],
                          spacing: 20.0,
                        ),
                      );
                    }

                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
