import 'package:flutter/material.dart';
import 'package:thumbing/firebase/firebase_firestore.dart';

import '../utility/constants.dart';
import '../widgets/leaderboard.dart';

class LeaderboardScreen extends StatefulWidget {
  static final kLeaderboardScreen = "LeaderboardScreen";

  @override
  State<StatefulWidget> createState() => _LeaderboardScreenState();
}

class OvalDisplayCard extends StatelessWidget {
  final String infoText;

  const OvalDisplayCard({Key? key, required this.infoText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade800,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 12.0, top: 8.0, right: 12.0, bottom: 8.0),
        child: Text(
          infoText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  var userName;
  var avgWPM;
  var avgAcc;
  var bestRank;

  setUserData() async {
    await MyCloudFirestore.getUser().then((value) {
      setState(() {
        userName = value?.userName;
        avgWPM = value?.wpm;
        avgAcc = value?.acc;
      });
    });
  }


  @override
  void initState() {
    setUserData();
    MyCloudFirestore.getUserRank().then((value){
      setState(() {
        bestRank = value;
        print('Best rank $value');
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple.shade600,
          elevation: 0,
          title: Text('Leaderboard'),
        ),
        backgroundColor: Colors.deepPurple.shade700,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/images/totoro.jpg'),
                      ),
                    ),
                    Text(
                      '$userName',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    OvalDisplayCard(infoText: "Rank $bestRank"),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OvalDisplayCard(
                          infoText: 'Avg WPM: $avgWPM',
                        ),
                        OvalDisplayCard(
                          infoText: 'Avg Acc: $avgAcc',
                        ),
                      ],
                    )
                  ],
                ),
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade600,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0)),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Leaderboard(
                  false,
                  BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0))),
            )),
          ],
        ),
      ),
    );
  }
}

/*
* DropdownButton(
                        value: dropDownValue,
                        style: kCardTextStyle,
                        icon: Icon(
                          Icons.arrow_downward,
                          color: Colors.white,
                          size: 20.0,
                        ),
                        underline: Container(
                          height: 4,
                          color: Colors.deepPurpleAccent,
                        ),
                        selectedItemBuilder: (BuildContext context) {
                          return leagues.map((String value) {
                            return Center(
                              child: Text(dropDownValue,
                                  style: kCardTextStyle.copyWith(fontSize: 16)),
                            );
                          }).toList();
                        },
                        items: leagues
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(
                              value,
                              style: kCardTextStyle.copyWith(
                                  color: Colors.deepPurple),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropDownValue = newValue!;
                          });
                        }),
* */
