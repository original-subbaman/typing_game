import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thumbing/firebase/firebase_constants.dart';
import 'package:thumbing/providers/auth_provider.dart';
import 'package:thumbing/screens/landing_page.dart';
import 'package:thumbing/screens/profile/profile_app_bar.dart';
import 'package:thumbing/screens/profile/sign_out_button.dart';
import 'package:thumbing/screens/profile/user_info_col.dart';
import 'package:thumbing/screens/profile/user_profile_img.dart';
import 'package:thumbing/screens/profile/username_title.dart';
import 'package:thumbing/screens/sign_in/sign_in.dart';

class ProfilePageScreen extends StatefulWidget {
  static final kProfilePageScreen = 'profile_page_Screen';

  ProfilePageScreen();

  @override
  State<ProfilePageScreen> createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen> {
  String fullName = "";
  String userName = "";
  String email = "";

  final kWhiteTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 18.0,
  );

  void setUserData() {
    FirebaseFirestore.instance
        .collection(kUserCollection)
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((docSnapshot) {
      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        if (this.mounted) {
          setState(() {
            fullName = data['full_name'];
            userName = data['user_name'];
            email = data['email'];
          });
        }
      }
    });
  }

  @override
  void initState() {
    setUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final authProvider = ref.read(authRepositoryProvider);
        return SafeArea(
          child: Scaffold(
            appBar: ProfileAppBar(),
            backgroundColor: Colors.deepPurple.shade800,
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    UserProfileImage(),
                    UsernameTitle(userName: this.userName,),
                    SizedBox(
                      height: 16,
                    ),
                    UserInfoColumn(
                      fullName: this.fullName,
                      userName: this.userName,
                      email: this.email,
                      textStyle: kWhiteTextStyle,
                    ),
                    Expanded(
                      child: SignOutButton(
                        onPressed: () => {
                          authProvider.signOutUser().then((value) =>
                              Navigator.pushNamedAndRemoveUntil(context,
                                  Wrapper.kLandingPage, (route) => false))
                        },
                        textStyle: kWhiteTextStyle,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
