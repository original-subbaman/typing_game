import 'package:flutter/material.dart';
import 'package:thumbing/firebase/firebase_constants.dart';

class UserInfoColumn extends StatelessWidget {
  var fullName;

  var userName;

  var email;

  var textStyle;

  UserInfoColumn(
      {super.key, this.fullName, this.userName, this.email, this.textStyle});

  Padding informationRow(
      {required String title,
      required String value,
      required String buttonText}) {
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
                  style: textStyle,
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
              style: textStyle.copyWith(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
