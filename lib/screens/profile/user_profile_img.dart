import 'package:flutter/material.dart';

class UserProfileImage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Hero(
        tag: 'profile_hero',
        child: CircleAvatar(
            radius: 50,
            child: ClipOval(
              child: Image.asset('assets/icons/user.png'),
            )),
      ),
    );
  }
}
