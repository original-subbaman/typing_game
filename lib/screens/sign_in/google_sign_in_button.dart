import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> print("tapped"),
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: 120),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Image.asset(
          "assets/icons/google_icon.png",
          height: 50,
        ),
      ),
    );
  }
}
