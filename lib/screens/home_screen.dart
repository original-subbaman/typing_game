import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thumbing/firebase/firebase_firestore.dart';
import 'package:thumbing/screens/profile_page.dart';
import 'package:thumbing/screens/test_settings.dart';
import 'package:thumbing/utility/constants.dart';
import 'package:thumbing/utility/current_best_score.dart';
import 'package:thumbing/widgets/leaderboard.dart';
import 'package:thumbing/widgets/single_value_card.dart';
import 'package:thumbing/widgets/value_display_card.dart';

import '../model/player.dart';

class HomeScreen extends StatefulWidget {
  static const kHomeRoute = 'home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String wpmText = 'WPM';
  final String accText = 'Accuracy';
  int wpmValueText = 0;
  int accValueText = 0;
  late String bestWPM;
  late String bestAcc;
  int leagueScore = 0;
  late String userName;



  void setUserDataToUI() async{
    await MyCloudFirestore.getUser().then((value){
     setState(() {
       if(value != null){
         this.userName = value.userName;
         this.leagueScore = value.leagueScore;
       }
     });
    });
  }

  getLatestWPM() async {
    return await CurrentBestScore.getLatestWPM();
  }

  getLatestAcc() async {
    return await CurrentBestScore.getLatestAcc();
  }

  getLeaderboardStats() async {
    return await MyCloudFirestore.getLeaderboard();
  }

  getUser() async {
    return await MyCloudFirestore.getUser();
  }

  @override
  void initState() {
    super.initState();
    setUserDataToUI();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0))),
          iconTheme: IconThemeData(color: kFABColor),
          elevation: 5,
          backgroundColor: kLightBlueAccent,
          title: FutureBuilder(
              future: MyCloudFirestore.getCurrentUserName(),
              builder: (context, snapshot) {
                var userName = "";
                if (snapshot.hasData) {
                  userName = snapshot.data.toString();
                }
                return Text(
                  "Hello $userName",
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }),
          actions: [
            GestureDetector(
              onTap: () => Navigator.pushNamed(
                  context, ProfilePageScreen.kProfilePageScreen),
              child: Container(
                margin: EdgeInsets.only(right: 8.0, top: 6.0),
                child: Hero(
                  tag: 'profile_hero',
                  child: Center(
                    child: CircleAvatar(
                      radius: 22,
                      backgroundImage: AssetImage('assets/icons/user.png'),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        backgroundColor: kBGColor,
        floatingActionButton: FloatingActionButton(
          backgroundColor: kFABColor,
          onPressed: () =>
              Navigator.pushNamed(context, TestSetting.kTestSetting),
          child: Image.asset("assets/icons/letter-t-.png"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: FutureBuilder(
                        future: getLatestWPM(),
                        builder: (context, snapshot) {
                          var displayCard = ValueDisplayCard(
                            titleText: wpmText,
                            valueText: '0',
                            titleTxtStyle: kCardTextStyle.copyWith(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            valueTxtStyle: kCardTextStyle.copyWith(
                              fontSize: 60,
                              color: Colors.white,
                            ),
                          );
                          if (snapshot.hasData) {
                            displayCard.valueText = snapshot.data.toString();
                          }
                          return displayCard;
                        }),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      flex: 1,
                      child: FutureBuilder(
                          future: getLatestAcc(),
                          builder: (context, snapshot) {
                            var displayCard = ValueDisplayCard(
                              titleText: accText,
                              valueText: accValueText.toString(),
                              bgColor: Colors.white,
                              titleTxtStyle: kCardTextStyle.copyWith(
                                  fontSize: 20, color: Colors.lightBlue),
                              valueTxtStyle: kCardTextStyle.copyWith(
                                fontSize: 60,
                                color: Colors.lightBlue,
                              ),
                            );
                            if (snapshot.hasData) {
                              displayCard.valueText = snapshot.data.toString();
                            }
                            return displayCard;
                          })),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              SingleValueCard('Current League Score', '$leagueScore'),
              SizedBox(
                height: 15.0,
              ),
              Expanded(
                child: Leaderboard(true, BorderRadius.circular(20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// List<LeaderboardItem> items = [
//   LeaderboardItem(
//       userImage: AssetImage('assets/images/gojo.jpg'),
//       userName: 'Satoru Gojo',
//       rank: '1',
//       upDownIcon: kRankUpIcon),
//   LeaderboardItem(
//       userImage: AssetImage('assets/images/saitama.jpg'),
//       userName: 'Saitama',
//       rank: '2',
//       upDownIcon: kRankUpIcon),
//   LeaderboardItem(
//       userImage: AssetImage('assets/images/saitama.jpg'),
//       userName: 'Escanor',
//       rank: '3',
//       upDownIcon: kRankDownIcon),
//   LeaderboardItem(
//       userImage: AssetImage('assets/images/saitama.jpg'),
//       userName: 'Madara Uchiha',
//       rank: '4',
//       upDownIcon: kRankUpIcon),
//   LeaderboardItem(
//       userImage: AssetImage('assets/images/saitama.jpg'),
//       userName: 'Son Goku',
//       rank: '5',
//       upDownIcon: kRankDownIcon),
//   LeaderboardItem(
//       userImage: AssetImage('assets/images/gojo.jpg'),
//       userName: 'Satoru Gojo',
//       rank: '1',
//       upDownIcon: kRankUpIcon),
//   LeaderboardItem(
//       userImage: AssetImage('assets/images/gojo.jpg'),
//       userName: 'Satoru Gojo',
//       rank: '1',
//       upDownIcon: kRankUpIcon),
// ];
