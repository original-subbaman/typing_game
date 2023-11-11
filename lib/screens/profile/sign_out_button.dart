import 'package:flutter/material.dart';

class SignOutButton extends StatelessWidget {
  var onPressed;
  var textStyle;

  SignOutButton({super.key, this.onPressed, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
          Colors.grey.withAlpha(50),
        )),
        onPressed: onPressed,
        child: Text(
          'Sign Out',
          style:
              textStyle.copyWith(fontSize: 22.0, fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}
