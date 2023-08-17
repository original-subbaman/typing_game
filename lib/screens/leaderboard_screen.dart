import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thumbing/firebase/firebase_firestore.dart';
import 'package:thumbing/screens/home_screen.dart';

import '../widgets/leaderboard.dart';

final userRankProvider = StateProvider((ref) => 1000);

class LeaderboardScreen extends ConsumerStatefulWidget{
  static final kLeaderboardScreen = "LeaderboardScreen";

  @override
  ConsumerState<LeaderboardScreen> createState() => _LeaderboardScreenState();
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

class _LeaderboardScreenState extends ConsumerState<LeaderboardScreen> {

  _setUserData() async {
    await MyCloudFirestore.getUser().then((value) {
      if(value != null){
        ref.read(userNameProvider.notifier).update((state) => value.userName);
        ref.read(wpmProvider.notifier).update((state) => value.wpm);
        ref.read(accProvider.notifier).update((state) => value.acc);
        print("best rank: ${value.bestRank}");
        ref.read(userRankProvider.notifier).update((state) => value.bestRank);
      }
    });
  }


  @override
  void initState() {
    _setUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userName = ref.watch(userNameProvider);
    final wpm = ref.watch(wpmProvider);
    final acc = ref.watch(accProvider);
    final bestRank = ref.watch(userRankProvider);

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
                          infoText: 'Avg WPM: $wpm',
                        ),
                        OvalDisplayCard(
                          infoText: 'Avg Acc: $acc',
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
