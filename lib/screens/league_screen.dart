import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thumbing/firebase/firebase_constants.dart';
import 'package:thumbing/firebase/firebase_firestore.dart';

class LeagueScreen extends StatefulWidget {
  static final kLeagueScreen = "League Screen";
  @override
  State<StatefulWidget> createState() => _LeagueScreenState();
}
Widget _buildLeaguesListView(stream){
  return StreamBuilder<QuerySnapshot>(
    stream: stream,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
      if (snapshot.hasError) {
        return Text('Something went wrong');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return Text("Loading");
      }

      return ListView(
        shrinkWrap: true,
        children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          print('name ${data['name']}]');
          print('admin ${data['admin']}]');

          return ListTile(
            tileColor: Colors.white,
            title: Text('this'),
            subtitle: Text('that'),
          );
        }).toList(),
      );
    }
  );
}

class _LeagueScreenState extends State<LeagueScreen> {
  final Stream<QuerySnapshot> _leagues = FirebaseFirestore.instance.collection(kLeagueCollection).snapshots();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Leagues"),

          ),
      backgroundColor: Colors.deepPurple.shade800,
      body: StreamBuilder<QuerySnapshot>(
          stream: _leagues,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return ListView(
              shrinkWrap: true,
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                print('name ${data['name']}]');
                print('admin ${data['admin']}]');

                return ListTile(
                  tileColor: Colors.white,
                  title: Text(data['name']),
                  subtitle: Text(data['admin']),
                );
              }).toList(),
            );
          }
      )
    ));
  }
}
