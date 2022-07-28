import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thumbing/firebase/firebase_constants.dart';
import 'package:thumbing/model/leaderboard_item.dart';
import 'package:thumbing/screens/profile_page.dart';
import 'package:thumbing/screens/test_settings.dart';
import 'package:thumbing/screens/typing_test_screen.dart';
import 'package:thumbing/utility/action_button_icon_icons.dart';
import 'package:thumbing/utility/constants.dart';
import 'package:thumbing/widgets/expandable_fab.dart';
import 'package:thumbing/widgets/leaderboard.dart';
import 'package:thumbing/widgets/single_value_card.dart';
import 'package:thumbing/widgets/value_display_card.dart';

class HomeScreen extends StatefulWidget {
  static const kHomeRoute = 'home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String avgWPMText = 'Avg WPM';
  final String avgAccText = 'Avg Accuracy';
  String wpmValueText = '120';
  String accValueText = '100';
  String bestWPM = '72';
  String bestAcc = '99';
  String userName;

  void getUserNameFromFirestore() {
    FirebaseFirestore.instance
        .collection(kUserCollection)
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data();
        setState(() {
          userName = data['user_name'];
        });
      }
    }).catchError((error) => print('error: $error'));
  }

  @override
  void initState() {
    super.initState();
    getUserNameFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: kFABColor),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            "Hello $userName",
            style: GoogleFonts.lato(
              color: Colors.lightBlue,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () => Navigator.pushNamed(
                  context, ProfilePageScreen.kProfilePageScreen),
              child: Container(
                margin: EdgeInsets.only(right: 8.0, top: 8.0),
                child: Hero(
                  tag: 'profile_hero',
                  child: Center(
                    child: CircleAvatar(
                      radius: 22,
                      backgroundImage: AssetImage('assets/images/totoro.jpg'),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        backgroundColor: kBGColor,
        floatingActionButton: FloatingActionButton(
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
                    child: ValueDisplayCard(
                      titleText: avgWPMText,
                      valueText: wpmValueText,
                      titleTxtStyle: kCardTextStyle.copyWith(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      valueTxtStyle: kCardTextStyle.copyWith(
                        fontSize: 60,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    flex: 1,
                    child: ValueDisplayCard(
                      titleText: avgAccText,
                      valueText: accValueText,
                      bgColor: Colors.white,
                      titleTxtStyle: kCardTextStyle.copyWith(
                          fontSize: 20, color: Colors.lightBlue),
                      valueTxtStyle: kCardTextStyle.copyWith(
                        fontSize: 60,
                        color: Colors.lightBlue,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              SingleValueCard('Your Current Rank', '256'),
              SizedBox(
                height: 15.0,
              ),
              Expanded(
                child: Leaderboard(items, true, BorderRadius.circular(20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<LeaderboardItem> items = [
  LeaderboardItem(
      userImage: AssetImage('assets/images/gojo.jpg'),
      userName: 'Satoru Gojo',
      rank: '1',
      upDownIcon: kRankUpIcon),
  LeaderboardItem(
      userImage: AssetImage('assets/images/saitama.jpg'),
      userName: 'Saitama',
      rank: '2',
      upDownIcon: kRankUpIcon),
  LeaderboardItem(
      userImage: AssetImage('assets/images/saitama.jpg'),
      userName: 'Escanor',
      rank: '3',
      upDownIcon: kRankDownIcon),
  LeaderboardItem(
      userImage: AssetImage('assets/images/saitama.jpg'),
      userName: 'Madara Uchiha',
      rank: '4',
      upDownIcon: kRankUpIcon),
  LeaderboardItem(
      userImage: AssetImage('assets/images/saitama.jpg'),
      userName: 'Son Goku',
      rank: '5',
      upDownIcon: kRankDownIcon),
  LeaderboardItem(
      userImage: AssetImage('assets/images/gojo.jpg'),
      userName: 'Satoru Gojo',
      rank: '1',
      upDownIcon: kRankUpIcon),
  LeaderboardItem(
      userImage: AssetImage('assets/images/gojo.jpg'),
      userName: 'Satoru Gojo',
      rank: '1',
      upDownIcon: kRankUpIcon),
];
