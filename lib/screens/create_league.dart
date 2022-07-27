import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thumbing/firebase/firebase_authentication.dart';
import 'package:thumbing/firebase/firebase_firestore.dart';
import 'package:thumbing/screens/home_screen.dart';
import 'package:thumbing/utility/constants.dart';

import '../model/league.dart';
import '../widgets/input_form_field.dart';

class CreateNewLeagueScreen extends StatefulWidget {
  static final kCreateNewLeagueScreen = "CreateNewLeagueScreen";

  @override
  State<StatefulWidget> createState() => _CreateNewLeagueScreen();
}

enum JoiningChoice { invite_only, open }

class _CreateNewLeagueScreen extends State<CreateNewLeagueScreen> {
  FocusNode _leagueNameFocusNode;
  TextEditingController _leagueNameController;

  Color getColorOnFocus(FocusNode focusNode) {
    return focusNode.hasFocus ? Colors.deepPurpleAccent : Colors.grey;
  }

  void _requestFocus(FocusNode focusNode) {
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  Text subTitleText({title}) {
    return Text(title,
        style: kCardTextStyle.copyWith(color: Colors.black, fontSize: 18.0));
  }


  JoiningChoice _joiningChoice = JoiningChoice.invite_only;
  List<String> players =[];
  int noOfPlayers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _leagueNameController = TextEditingController();
    _leagueNameFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _leagueNameFocusNode.dispose();
    _leagueNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.deepPurple),
          elevation: 0,
          title: Text(
            'Create a New League',
            style: TextStyle(color: Colors.deepPurple),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    fit: FlexFit.loose,
                    child: subTitleText(title: 'Decide your league name')),
                SizedBox(
                  height: 20.0,
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: InputFormField(
                    focusNode: _leagueNameFocusNode,
                    controller: _leagueNameController,
                    hintText: 'A cool league name',
                    labelText: 'League Name',
                    obscureText: false,
                    onTap: () => _requestFocus(_leagueNameFocusNode),
                    labelStyle: TextStyle(
                      color: getColorOnFocus(_leagueNameFocusNode),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Flexible(
                    fit: FlexFit.loose,
                    child: subTitleText(title: 'Choose how players join')),
                SizedBox(
                  height: 15.0,
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 4.0),
                    title: Transform.translate(
                        offset: Offset(-16, 0), child: Text('Invite only')),
                    leading: Radio<JoiningChoice>(
                      value: JoiningChoice.invite_only,
                      groupValue: _joiningChoice,
                      onChanged: (JoiningChoice value) {
                        setState(() {
                          _joiningChoice = value;
                        });
                      },
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 4.0),
                    title: Transform.translate(
                        offset: Offset(-16, 0), child: Text('Open')),
                    leading: Radio<JoiningChoice>(
                      value: JoiningChoice.open,
                      groupValue: _joiningChoice,
                      onChanged: (JoiningChoice value) {
                        setState(() {
                          _joiningChoice = value;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () async {
                          players.add(MyFirebaseAuth.currentUserId);
                          League newLeague = League(
                            adminName:
                                await MyCloudFirestore.getCurrentUserName(),
                            adminId: MyFirebaseAuth.currentUserId,
                            leagueTitle: _leagueNameController.text,
                            joinCondition: _joiningChoice.toString(),
                            players: players,
                          );
                          MyCloudFirestore.addLeague(league: newLeague);
                          Navigator.popAndPushNamed(context, HomeScreen.kHomeRoute);
                        },
                        child: Text(
                          'Create',
                          style: kCardTextStyle.copyWith(fontSize: 18.0),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.deepPurple.shade500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
