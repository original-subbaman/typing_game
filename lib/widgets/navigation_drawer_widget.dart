import 'package:flutter/material.dart';
import 'package:thumbing/utility/constants.dart';

class NavigationDrawerWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: Material(
        child: Container(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'The Typing Game',
                  style: kCardTextStyle.copyWith(color: Colors.deepPurple, fontSize: 22),
                ),
              ),
              buildMenuItems(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItems() {
    final color = Colors.white;
    final hoverColor = Colors.deepPurple;

    return ListTile(
      leading: Icon(Icons.airline_seat_flat, color: color,),
      title: Text('some text'),
      hoverColor: hoverColor,
      onTap: (){},
    );

  }
  
}