import 'package:flutter/material.dart';
import 'package:thumbing/screens/create_league.dart';
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
              createListTile(context: context, title: 'Leagues',ontap: (){Navigator.popAndPushNamed(context, LeagueScreen.kLeagueScreen);}),
              createListTile(context: context, title: 'Create New League', ontap: (){Navigator.popAndPushNamed(context, CreateNewLeagueScreen.kCreateNewLeagueScreen);}),

            ],
          ),
        ),
      ),
    );
  }

  Widget createListTile({context, title, ontap}) {
    final color = Colors.white;
    final hoverColor = Colors.deepPurple;

    return ListTile(
      title: Text(title, style: kCardTextStyle,),
      hoverColor: hoverColor,
      onTap: ontap,
    );

  }
  
}