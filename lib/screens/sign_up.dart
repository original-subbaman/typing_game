import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thumbing/firebase/firebase_firestore.dart';
import 'package:thumbing/screens/home_screen.dart';
import 'package:thumbing/screens/sign_in.dart';
import 'package:thumbing/firebase/firebase_authentication.dart';
import 'package:thumbing/utility/current_best_score.dart';
import 'package:thumbing/widgets/social_media_button.dart';
import 'package:thumbing/widgets/input_form_field.dart';
import 'package:thumbing/utility/constants.dart';

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
  FocusNode _emailFocusNode;
  FocusNode _passwordFocusNode;
  FocusNode _usernameFocusNode;
  FocusNode _fullNameFocusNode;
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController _userNameController;
  TextEditingController _passwordController;
  TextEditingController _emailController;
  TextEditingController _fullNameController;

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
    return focusNode.hasFocus ? Colors.deepPurpleAccent : Colors.grey;
  }

  void _requestFocus(FocusNode focusNode) {
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  Future<String> signUpUser() async{
    return await MyFirebaseAuth.signUpUser(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());
  }

  Future<String> createNewUser() async{
    CurrentBestScore.setLatestWPM(0); //Setting initial best WPM for a new user in Shared Preferences
    CurrentBestScore.setLatestAcc(0); //Setting initial best Acc for a new user in Shared Preferences
    return  await MyCloudFirestore.addUser(
        uid: FirebaseAuth.instance.currentUser.uid,
        username: _userNameController.text.trim(),
        fullName: _fullNameController.text.trim(),
        email: _emailController.text.trim());
  }

  void showUserSignUpException(String status){
    switch(status){
      case "weak-password":
      //show weak password toast
        showSnackBar(msg: widget.kWeakPassword, context: context);
        break;
      case "email-already-in-use":
      //show email already in use toast
        showSnackBar(msg: widget.kEmailAlreadyInUse, context: context);
        break;
      case "invalid-email":
        showSnackBar(msg: widget.kInvalidEmail, context: context);
        break;
      default:
      //show error toast
        showSnackBar(msg: widget.kDefaultError, context: context);
    }
  }

  void showCreateUserException(String status){
    switch(status){
      case "success":
        Navigator.pushNamed(context, HomeScreen.kHomeRoute);
        break;
      default:
        showSnackBar(msg: "Error creating user. Try again.", context: context);
        MyFirebaseAuth.deleteCurrentUser();
    }
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FittedBox(
          child: FloatingActionButton(
            child: Icon(Icons.login),
            backgroundColor: Colors.deepPurpleAccent,
            onPressed: () async {
              dismissKeyboard();
              String status = await signUpUser();
              if(status != "success") {
                showUserSignUpException(status);
                return;
              }
              status = await createNewUser();
              showCreateUserException(status);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              flex: 2,
              fit: FlexFit.loose,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Sign Up',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Log In with Google or Facebook',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SocialMediaButton(
                                logoResource: 'assets/images/google_logo.png',
                                onPressed: () {}),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            child: SocialMediaButton(
                              logoResource: 'assets/images/facebook_logo.png',
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Log In with Email and Password',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
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
                        labelText: 'Full Name',
                        labelStyle: TextStyle(
                          color: getColorOnFocus(_fullNameFocusNode),
                        ),
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
                        labelText: 'Username',
                        labelStyle: TextStyle(
                          color: getColorOnFocus(_usernameFocusNode),
                        ),
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
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: getColorOnFocus(_emailFocusNode),
                        ),
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
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: getColorOnFocus(_passwordFocusNode),
                        ),
                        controller: _passwordController,
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                            children: [
                              TextSpan(text: 'Already have an account? '),
                              TextSpan(
                                  text: 'Sign In',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(
                                          context, SignInScreen.kSignInScreen);
                                    }),
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
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
    // TODO: implement dispose
    super.dispose();
    disposeFocusNodes();
    disposeControllers();
  }


}
