import 'package:flutter/material.dart';
import 'package:thumbing/utility/constants.dart';

class ProfilePageScreen extends StatelessWidget {
  static final kProfilePageScreen = 'profile_page_Screen';
  final kWhiteTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 18.0,
  );

  Padding InformationRow( {String title, String value, String buttonText}) {
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
                  style: kWhiteTextStyle,
                )
              ],
            ),
          ),
          TextButton(
            onPressed: null,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  Colors.grey.withAlpha(50)),
            ),
            child: Text(
             buttonText,
              style: kWhiteTextStyle.copyWith(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }

  ProfilePageScreen();

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueGrey.shade800.withAlpha(50),
            title: Text(
              'My Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: kVeryDarkPurple,
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    child: Hero(
                      tag: 'profile_hero',
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/images/totoro.jpg'),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      'Totoro Yo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(50),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: [
                        InformationRow(
                          title: 'Display Name',
                          value: 'Totoro Yo',
                          buttonText: 'Edit',
                        ),
                        InformationRow(
                          title: 'Email',
                          value: 'totoro@overtherainbow.com',
                          buttonText: 'Edit',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.grey.withAlpha(50),
                          )
                        ),
                        child: Text(
                          'Sign Out',
                          style: kWhiteTextStyle.copyWith(fontSize: 22),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
