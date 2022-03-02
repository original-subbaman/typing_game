import 'package:flutter/material.dart';
import 'package:thumbing/screens/league_screen.dart';
import 'package:thumbing/utility/constants.dart';

class NavigationDrawerWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: Material(
        color: Colors.deepPurple.shade500,
        child: Container(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'The Typing Game',
                  style: kCardTextStyle.copyWith(fontSize: 22),
                ),
              ),
              buildMenuItems(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItems(context) {
    final color = Colors.white;
    final hoverColor = Colors.deepPurple;

    return ListTile(
      leading: Icon(Icons.bar_chart_rounded, color: color,),
      title: Text('Leagues', style: kCardTextStyle,),
      hoverColor: hoverColor,
      onTap: (){

        Navigator.popAndPushNamed(context, LeagueScreen.kLeagueScreen);


      },
    );

  }
  
}