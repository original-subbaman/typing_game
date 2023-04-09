import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thumbing/firebase/firebase_firestore.dart';
import 'package:thumbing/screens/home_screen.dart';
import 'package:thumbing/screens/sign_in.dart';

class Wrapper extends StatefulWidget{
  static final kLandingPage = 'Landing Page';
  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper>{
  User? _user;
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((user) =>{
        if(user != null){
          updateUserState(user)
    }});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(_user == null){
      return SignInScreen();
    }else{
      return HomeScreen();
    }
  }

  updateUserState(User user) {
    setState(() {
      _user = user;
    });
  }

}