import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thumbing/firebase/firebase_firestore.dart';
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
  setPlayerRank(){
    for(var i = 0; i < items.length; i++){
      if(MyCloudFirestore.currentUser == items[i].userName){
        MyCloudFirestore.currentRank= i + 1;
      }
    }
  }

  setLeagueData() async {
    await MyCloudFirestore.getLeaderboard().then((value) {
      setState(() {
        items = value;
        setPlayerRank();
      });
    });
  }

  @override
  void initState() {
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
              left: 20.0, right: 20.0, top: 12.0, bottom: 20.0),
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
                          setLeagueData();
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
                    return ListTile(
                      title: Text(
                        items[index].userName,
                        style: kCardTextStyle,
                      ),
                      trailing: Text(
                        items[index].rank.toString(),
                        style: kCardTextStyle.copyWith(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    );
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
