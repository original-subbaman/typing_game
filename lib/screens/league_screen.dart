/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thumbing/firebase/firebase_constants.dart';
import 'package:thumbing/firebase/firebase_firestore.dart';
import 'package:thumbing/screens/create_league.dart';
import 'package:thumbing/utility/constants.dart';
import 'package:thumbing/widgets/input_form_field.dart';

class LeagueScreen extends StatefulWidget {
  static final kLeagueScreen = "League Screen";

  @override
  State<StatefulWidget> createState() => _LeagueScreenState();
}

void showJoinLeagueDialog(context){
  showDialog(context: context, builder: (_)=>AlertDialog(
    title: Text('Do you want to join this league?'),
    content: Text('You can only join one league at a time.'),
    actions: [
      TextButton(onPressed: (){
        Navigator.pop(context);
      }, child: Text('No')),
      TextButton(onPressed: (){}, child: Text('Yes')),
    ],

  ));
}

void showSendRequestDialog(context){
  showDialog(context: context, builder: (_)=>AlertDialog(
    title: Text('Send request to join'),
    content: Text('This league is private. Send a join request to the admin.'),
    actions: [
      TextButton(onPressed: (){
        Navigator.pop(context);
      }, child: Text('No')),
      TextButton(onPressed: (){}, child: Text('Yes')),
    ],

  ));
}

class _LeagueScreenState extends State<LeagueScreen> {
  final Stream<QuerySnapshot> _leagues =
      FirebaseFirestore.instance.collection(kLeagueCollection).snapshots();
  final joiningChoiceInviteOnly = "JoiningChoice.invite_only";
  final joiningChoiceOpen = "JoiningChoice.Open";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurple.shade800,
              elevation: 0,
              title: Text("Leagues"),
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.search)),
              ],
            ),
            backgroundColor: Colors.deepPurple.shade800,
            body: StreamBuilder<QuerySnapshot>(
                stream: _leagues,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }
                  return ListView(
                    shrinkWrap: true,
                    children:
                        snapshot.data?.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      String joinCondition =
                          data['joinCondition'] == "JoiningChoice.invite_only"
                              ? "Invite Only"
                              : "Open";
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Card(
                            elevation: 4.0,
                            shadowColor: Colors.grey.shade800,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${data['leagueTitle']}",
                                        style: kCardTextStyle.copyWith(
                                            color: Colors.black, fontSize: 24.0),
                                      ),
                                      Text(
                                        "Admin: ${data['adminName']}",
                                        style: kCardTextStyle.copyWith(
                                            color: Colors.black, fontSize: 12.0),
                                      ),
                                      Text(
                                        joinCondition,
                                        style: kCardTextStyle.copyWith(
                                            color: Colors.black, fontSize: 12.0),
                                      )
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        if(data['joinCondition'].toString() == joiningChoiceInviteOnly){
                                          showSendRequestDialog(context);
                                        }else{
                                          showJoinLeagueDialog(context);
                                        }
                                      },
                                      icon: Icon(
                                        Icons.arrow_circle_up,
                                        color: Colors.green,
                                        size: 45,
                                      )),
                                ],
                              ),
                            )),
                      );
                    }).toList(),
                  );
                })));
  }
}
*/