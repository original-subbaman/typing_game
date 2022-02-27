import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/leaderboard_item.dart';
import '../utility/constants.dart';
import '../widgets/leaderboard.dart';

class LeaderboardScreen extends StatefulWidget {
  static final kLeaderboardScreen = "LeaderboardScreen";

  @override
  State<StatefulWidget> createState() => _LeaderboardScreenState();
}

class OvalDisplayCard extends StatelessWidget{
  final String infoText;

  const OvalDisplayCard({Key key, this.infoText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade800,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0,
            top: 8.0,
            right: 12.0,
            bottom: 8.0),
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
  String dropDownValue = "League 1";
  List<String> leagues = ['League 1', 'League 2', 'League 3', 'League 4', 'League 5'];
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
                        backgroundImage: AssetImage(
                            'assets/images/totoro.jpg'),
                      ),
                    ),
                    Text(
                      'Totoro Yo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    OvalDisplayCard(infoText: 'Rank 12',),
                    SizedBox(height: 10,),
                    DropdownButton(
                        value: dropDownValue,
                        style: kCardTextStyle,
                        icon: Icon(Icons.arrow_downward, color: Colors.white, size: 20.0,),
                        underline: Container(
                          height: 4,
                          color: Colors.deepPurpleAccent,
                        ),
                        selectedItemBuilder: (BuildContext context){
                          return leagues.map((String value){
                            return Center(
                              child: Text(
                                dropDownValue,
                                style: kCardTextStyle.copyWith(fontSize: 16)
                              ),
                            );
                          }).toList();
                        },
                        items: leagues
                        .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value, style: kCardTextStyle.copyWith(color: Colors.deepPurple),),
                          );
                    }).toList(), onChanged: (String newValue){
                      setState(() {
                        dropDownValue = newValue;
                      });
                    }),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OvalDisplayCard(infoText: 'Avg WPM: 77',),
                        OvalDisplayCard(infoText: 'Avg Acc: 99',),
                        OvalDisplayCard(infoText: 'Best Rank: 1',)
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
            SizedBox(height: 10.0,),
            Expanded(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Leaderboard(items, false, BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
            )),
          ],
        ),
      ),
    );
  }
}
