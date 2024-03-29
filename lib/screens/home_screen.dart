import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thumbing/firebase/firebase_firestore.dart';
import 'package:thumbing/providers/player_provider.dart';
import 'package:thumbing/screens/profile/profile_page.dart';
import 'package:thumbing/screens/test_settings.dart';
import 'package:thumbing/utility/constants.dart';
import 'package:thumbing/utility/current_best_score.dart';
import 'package:thumbing/widgets/leaderboard.dart';
import 'package:thumbing/widgets/single_value_card.dart';
import 'package:thumbing/widgets/value_display_card.dart';

import '../model/player.dart';
import '../utility/colors.dart';

final userNameProvider = StateProvider<String>((ref) => 'Player');
final leagueScoreProvider = StateProvider<int>((ref) => 0);
final wpmProvider = StateProvider((ref) => 0);
final accProvider = StateProvider((ref) => 0);

class HomeScreen extends ConsumerStatefulWidget {
  static const kHomeRoute = 'home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final String wpmText = 'WPM';
  final String accText = 'Accuracy';


  _getLatestWPM() async {
    return await CurrentBestScore.getLatestWPM().then((value){
      if(value != null){
        ref.read(wpmProvider.notifier).update((state) => value);
      }
    });
  }

  _getLatestAcc() async {
    return await CurrentBestScore.getLatestAcc().then((value){
      if(value != null){
        ref.read(accProvider.notifier).update((state) => value);
      }
    });
  }



  @override
  void initState() {
    super.initState();
    _getLatestAcc();
    _getLatestWPM();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(playerProvider);

    return user.when(data: (userData) => SafeArea(
      child: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0))),
          iconTheme: IconThemeData(color: kFABColor),
          elevation: 5,
          backgroundColor: kLightBlueAccent,
          title: Text(
            "Hello ${userData.userName}",
            style: GoogleFonts.lato(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
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
                    child: ValueDisplayCard(
                      titleText: wpmText,
                      valueText: '${userData.wpm}',
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
                      titleText: accText,
                      valueText: '${userData.acc}',
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
              SingleValueCard('Current League Score', '${userData.leagueScore}'),
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
    ), error: (error, _) => Center(
      child: Text(error.toString(), style: const TextStyle(color: Colors.red),),
    ), loading: () => const Center(
      child: CircularProgressIndicator(),
    ));
  }
}
