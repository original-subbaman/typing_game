import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thumbing/model/expanded_screen_arguments.dart';
import 'package:thumbing/screens/expanded_wpm_screen.dart';
import 'package:thumbing/utility/constants.dart';
import 'package:thumbing/widgets/value_display_card.dart';
import 'package:thumbing/model/leaderboard_item.dart';

import 'expanded_acc_screen.dart';

class HomeScreen extends StatefulWidget {
  static const kHomeRoute = 'home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
  final String avgWPMText = 'Avg WPM';
  final String avgAccText = 'Avg Accuracy';
  String wpmValueText = '60';
  String accValueText = '98';
  String bestWPM = '72';
  String bestAcc = '99';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple.shade700,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              //Head
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hello, Totoro',
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/images/totoro.jpg'),
                  )
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(
                          context,
                          ExpandedWPMScreen.kExpandedWPMScreen,
                          arguments: ExpandedScreenArguments(
                              avgWPMText,
                              Colors.white,
                              wpmValueText,
                              Colors.white,
                              null,
                              bestWPM,
                          ),
                      );
                    },
                    child: Hero(
                      tag: 'wpmExpand',
                      child: ValueDisplayCard(
                        titleText: avgWPMText,
                        valueText: wpmValueText,
                        paddingHorizontal: 30,
                        titleTxtStyle: kCardTextStyle.copyWith(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        valueTxtStyle: kCardTextStyle.copyWith(
                          fontSize: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context,
                        ExpandedAccScreen.kExpandedAccScreen,
                      arguments: ExpandedScreenArguments(
                          avgAccText,
                          Colors.deepPurple,
                          accValueText,
                          Colors.deepPurple,
                          Colors.white,
                          bestAcc,
                      )
                    ),
                    child: Hero(
                      tag: 'accExpand',
                      child: ValueDisplayCard(
                        titleText: avgAccText,
                        valueText: accValueText,
                        bgColor: Colors.white,
                        titleTxtStyle: kCardTextStyle.copyWith(
                            fontSize: 20, color: Colors.deepPurple),
                        valueTxtStyle: kCardTextStyle.copyWith(
                          fontSize: 50,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Material(
                elevation: 10.0,
                shadowColor: Colors.deepPurpleAccent.shade400,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Your Current Rank',
                            textAlign: TextAlign.left,
                            style: kCardTextStyle.copyWith(
                              color: Colors.deepPurple,
                            ),
                          ),
                        ),
                        Text('246',
                            style: kCardTextStyle.copyWith(
                              color: Colors.deepPurple,
                            )),
                        kRankUpIcon,
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Expanded(
                child: Material(
                  elevation: 10.0,
                  shadowColor: Colors.deepPurpleAccent.shade400,
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Leaderboard',
                            textAlign: TextAlign.left,
                            style: kCardTextStyle.copyWith(
                              fontSize: 18,
                            ),
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
                                  leading: CircleAvatar(
                                    backgroundImage: items[index].userImage,
                                  ),
                                  trailing: Text(
                                    items[index].rank,
                                    style:
                                        kCardTextStyle.copyWith(fontSize: 15),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
