import 'package:flutter/material.dart';

class SecondaryTitle extends StatelessWidget {
  var title;
  SecondaryTitle({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w300,
        fontSize: 20.0,
      ),
      textAlign: TextAlign.center,
    );
  }
}
