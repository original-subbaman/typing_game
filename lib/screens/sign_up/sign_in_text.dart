import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../sign_in/sign_in.dart';

class SignInText extends StatelessWidget {
  const SignInText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
          children: [
            TextSpan(text: 'Already have an account? '),
            TextSpan(
                text: 'Sign In',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, SignInScreen.kSignInScreen);
                  }),
          ]),
    );
  }
}
