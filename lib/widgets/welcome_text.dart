import 'package:flutter/material.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Welcome',
      style: TextStyle(
        fontSize: 42,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    );
  }
}
