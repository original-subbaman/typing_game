import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thumbing/screens/expanded_acc_screen.dart';
import 'package:thumbing/screens/expanded_wpm_screen.dart';
import 'package:thumbing/screens/home_screen.dart';
import 'package:thumbing/screens/profile_page.dart';
import 'package:thumbing/screens/sign_in.dart';
import 'package:thumbing/screens/typing_test_screen.dart';
import 'package:thumbing/utility/constants.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SignInScreen.kSignInScreen,
      routes: {
        HomeScreen.kHomeRoute: (context) => HomeScreen(),
        TypingTestScreen.kTypingScreenRoute: (context) => TypingTestScreen(),
        ExpandedWPMScreen.kExpandedWPMScreen: (context) => ExpandedWPMScreen(),
        ExpandedAccScreen.kExpandedAccScreen: (context) => ExpandedAccScreen(),
        ProfilePageScreen.kProfilePageScreen: (context) => ProfilePageScreen(),
        SignInScreen.kSignInScreen: (context) => SignInScreen(),
      }
    ),
  );
}
