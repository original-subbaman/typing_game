import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thumbing/firebase/firebase_firestore.dart';
import 'package:thumbing/providers/auth_provider.dart';
import 'package:thumbing/screens/home_screen.dart';
import 'package:thumbing/screens/sign_in/sign_in.dart';
import 'package:thumbing/screens/sign_up/sign_in_text.dart';
import 'package:thumbing/utility/constants.dart';
import 'package:thumbing/utility/current_best_score.dart';
import 'package:thumbing/widgets/input_form_field.dart';
import 'package:thumbing/widgets/secondary_title_text.dart';
import 'package:thumbing/widgets/welcome_text.dart';
import 'package:thumbing/firebase/firebase_constants.dart';

import '../../model/player.dart';
import '../../utility/colors.dart';

class SignUpScreen extends StatefulWidget {
  static final kSignUpScreen = 'kSignUpScreen';
  final kWeakPassword = 'Your password is too weak.';
  final kEmailAlreadyInUse = 'The email provided is already in use';
  final kDefaultError = 'Error Signing Up. Try again.';
  final kInvalidEmail = 'The email you provided is invalid';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;
  late FocusNode _usernameFocusNode;
  late FocusNode _fullNameFocusNode;
  FirebaseAuth auth = FirebaseAuth.instance;

  late TextEditingController _userNameController;
  late TextEditingController _passwordController;
  late TextEditingController _emailController;
  late TextEditingController _fullNameController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _usernameFocusNode = FocusNode();
    _fullNameFocusNode = FocusNode();
    _userNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _fullNameController = TextEditingController();
  }

  Color getColorOnFocus(FocusNode focusNode) {
    return focusNode.hasFocus ? kLightBlueAccent : Colors.grey;
  }

  void _requestFocus(FocusNode focusNode) {
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  /*Future<String> signUpUser() async {
    return await MyFirebaseAuth.signUpUser(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());
  }*/

  Player createNewPlayer() {
    CurrentBestScore.setLatestWPM(
        0); //Setting initial best WPM for a new user in Shared Preferences
    CurrentBestScore.setLatestAcc(
        0); //Setting initial best Acc for a new user in Shared Preferences

    return Player(
      uid: FirebaseAuth.instance.currentUser?.uid,
      fullName: _fullNameController.text.trim(),
      email: _emailController.text.trim(),
      leagueScore: 0,
      userName: _userNameController.text.trim(),
      acc: 0,
      wpm: 0,
      bestRank: 1000,
    );


  }

  void createNewUserInFirestore(){
    showDialog(
        context: context,
        builder: (context) => Center(child: CircularProgressIndicator()));
  }

  void showUserSignUpException(String status) {
    switch (status) {
      case WEAK_PASSWORD:
        //show weak password toast
        showSnackBar(msg: widget.kWeakPassword, context: context);
        break;
      case EMAIL_ALREADY_IN_USE:
        //show email already in use toast
        showSnackBar(msg: widget.kEmailAlreadyInUse, context: context);
        break;
      case INVALID_EMAIL:
        showSnackBar(msg: widget.kInvalidEmail, context: context);
        break;
      default:
        //show error toast
        showSnackBar(msg: widget.kDefaultError, context: context);
    }
  }

  showCreateUserException(String status) {
    if(status == SUCCESS){
      Navigator.popAndPushNamed(context, HomeScreen.kHomeRoute);
    }else{
      showSnackBar(msg: "Error creating user. Try again.", context: context);
      //TODO: Delete User
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, SignInScreen.kSignInScreen);
        return true;
      },
      child: Consumer(
        builder: (context, ref, child) {
          final authProvider = ref.read(authRepositoryProvider);
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              floatingActionButton: SizedBox(
                width: 70,
                height: 70,
                child: FittedBox(
                  child: FloatingActionButton(
                    child: Icon(Icons.login),
                    backgroundColor: kLightBlueAccent,
                    onPressed: () async {
                      dismissKeyboard();
                      String status = await authProvider.signUpUser(
                          email: _emailController.text.toString(),
                          password: _passwordController.text.toString());
                      if (status != "success") {
                        showUserSignUpException(status);
                      }else{
                        createNewPlayer();
                      }
                    },
                  ),
                ),
              ),
              body: Stack(children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: shades,
                      stops: [0.1, 0.4, 0.7, 0.9],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    vertical: 120,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            WelcomeText(),
                            SizedBox(
                              height: 20,
                            ),
                            SecondaryTitle(
                              title: "Sign-up to get started",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InputFormField(
                              focusNode: _fullNameFocusNode,
                              prefixIcon: Icon(Icons.emoji_emotions_outlined,
                                  color: getColorOnFocus(_fullNameFocusNode)),
                              onTap: () => _requestFocus(_fullNameFocusNode),
                              hintText: 'Your full name',
                              controller: _fullNameController,
                              obscureText: false,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InputFormField(
                              focusNode: _usernameFocusNode,
                              prefixIcon: Icon(Icons.account_circle_outlined,
                                  color: getColorOnFocus(_usernameFocusNode)),
                              onTap: () => _requestFocus(_usernameFocusNode),
                              hintText: 'Your cool username',
                              controller: _userNameController,
                              obscureText: false,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InputFormField(
                              focusNode: _emailFocusNode,
                              prefixIcon: Icon(Icons.email,
                                  color: getColorOnFocus(_emailFocusNode)),
                              onTap: () => _requestFocus(_emailFocusNode),
                              hintText: 'someone@email.com',
                              controller: _emailController,
                              obscureText: false,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InputFormField(
                              focusNode: _passwordFocusNode,
                              prefixIcon: Icon(Icons.password,
                                  color: getColorOnFocus(_passwordFocusNode)),
                              onTap: () => _requestFocus(_passwordFocusNode),
                              hintText: 'Password',
                              controller: _passwordController,
                              obscureText: true,
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            SignInText(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }

  void disposeFocusNodes() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _usernameFocusNode.dispose();
    _fullNameFocusNode.dispose();
  }

  void disposeControllers() {
    _userNameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _fullNameController.dispose();
  }

  @override
  void dispose() {
    super.dispose();
    disposeFocusNodes();
    disposeControllers();
  }
}
