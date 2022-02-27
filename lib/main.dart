import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thumbing/screens/Wrapper.dart';
import 'package:thumbing/screens/expanded_acc_screen.dart';
import 'package:thumbing/screens/expanded_wpm_screen.dart';
import 'package:thumbing/screens/home_screen.dart';
import 'package:thumbing/screens/leaderboard_screen.dart';
import 'package:thumbing/screens/profile_page.dart';
import 'package:thumbing/screens/sign_in.dart';
import 'package:thumbing/screens/sign_up.dart';
import 'package:thumbing/screens/typing_test_screen.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Wrapper.kWrapperRoute,
      routes: {
        Wrapper.kWrapperRoute: (context) => Wrapper(),
        HomeScreen.kHomeRoute: (context) => HomeScreen(),
        TypingTestScreen.kTypingScreenRoute: (context) => TypingTestScreen(),
        ExpandedWPMScreen.kExpandedWPMScreen: (context) => ExpandedWPMScreen(),
        ExpandedAccScreen.kExpandedAccScreen: (context) => ExpandedAccScreen(),
        ProfilePageScreen.kProfilePageScreen: (context) => ProfilePageScreen(),
        SignInScreen.kSignInScreen: (context) => SignInScreen(),
        SignUpScreen.kSignUpScreen: (context) => SignUpScreen(),
        LeaderboardScreen.kLeaderboardScreen: (context) => LeaderboardScreen(),

      }
    ),
  );

}
