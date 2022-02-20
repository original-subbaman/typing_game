import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thumbing/screens/home_screen.dart';
import 'package:thumbing/screens/sign_in.dart';

class Wrapper extends StatefulWidget{
  static final kWrapperRoute = 'Wrapper';
  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper>{
  User user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((event) => updateUserState(event)); 
  }
  @override
  Widget build(BuildContext context) {
    if(user == null){
      return SignInScreen();
    }else{
      return HomeScreen();
    }
  }

  updateUserState(User event) {
    setState(() {
      user = event;
    });
  }

}