
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBanner extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.8),
              spreadRadius: 5,
              blurRadius: 4,
              offset: Offset(0, 3),
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'TapTap',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 60,
              color: Colors.white,
            ),
          ),
          Text(
            'A typing game',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 18,
                color: Colors.white),
          ),
          SizedBox(
            height: 20,
          ),

        ],
      ),
    );
  }
}
