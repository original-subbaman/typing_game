import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thumbing/screens/home_screen.dart';
import 'package:thumbing/screens/sign_in.dart';
import 'package:thumbing/utility/constants.dart';
import 'package:thumbing/firebase/firebase_constants.dart';
import '../firebase/firebase_authentication.dart';

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

  Padding informationRow({required String title, required String value, required String buttonText}) {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade400,
                  ),
                ),
                Text(
                  value,
                  style: kWhiteTextStyle,
                )
              ],
            ),
          ),
          TextButton(
            onPressed: null,
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Colors.grey.withAlpha(50)),
            ),
            child: Text(
              buttonText,
              style: kWhiteTextStyle.copyWith(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }

  void setUserData() {
    FirebaseFirestore.instance
        .collection(kUserCollection)
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((docSnapshot) {
      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        if(this.mounted){
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
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurple.shade800,
            elevation: 0.0,
            title: Text(
              'My Profile',
              style: GoogleFonts.lato(
                  fontSize: 22.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
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
                  Container(
                    child: Hero(
                      tag: 'profile_hero',
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/images/totoro.jpg'),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      '$userName',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(50),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: [
                        informationRow(
                          title: 'Full Name',
                          value: '$fullName',
                          buttonText: 'Edit',
                        ),
                        informationRow(
                          title: 'User Name',
                          value: '$userName',
                          buttonText: 'Edit',
                        ),
                        informationRow(
                          title: 'Email',
                          value: '$email',
                          buttonText: 'Edit',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                          Colors.grey.withAlpha(50),
                        )),
                        onPressed: () {
                           MyFirebaseAuth.signOutUser().then((status)=> Navigator.popAndPushNamed(context, SignInScreen.kSignInScreen));
                        },
                        child: Text(
                          'Sign Out',
                          style: kWhiteTextStyle.copyWith(fontSize: 22, fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
