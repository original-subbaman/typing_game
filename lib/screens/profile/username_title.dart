import 'package:flutter/material.dart';

class UsernameTitle extends StatelessWidget {
  var userName;

  UsernameTitle({super.key, this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
