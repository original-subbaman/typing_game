import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thumbing/screens/home_screen.dart';
import 'package:thumbing/screens/sign_up.dart';
import 'package:thumbing/utility/constants.dart';
import 'package:thumbing/widgets/social_media_button.dart';
import 'package:thumbing/widgets/input_form_field.dart';
import '../firebase/firebase_authentication.dart';

class SignInScreen extends StatefulWidget {
  static final kSignInScreen = 'kSignInScreen';
  final _kUserNotFound = 'No user found for this email.';
  final _kWrongPassword = 'Wrong password. Please try again.';
  final _kDefaultError = 'Error logging in. Please try again.';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  FocusNode _emailFocusNode;
  FocusNode _passwordFocusNode;
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController _emailController;
  TextEditingController _passwordController;

  Color getColorOnFocus(FocusNode focusNode) {
    return focusNode.hasFocus ? Colors.deepPurpleAccent : Colors.grey;
  }

  void _requestFocus(FocusNode focusNode) {
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  void disposeTextControllers() {
    _emailController.dispose();
    _passwordController.dispose();
  }

  void disposeFocusNodes() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  void handleSignInExceptions(String status) {
    switch (status) {
      case 'user-not-found':
        showSnackBar(msg: widget._kUserNotFound, context: context);
        break;
      case 'wrong-password':
        showSnackBar(msg: widget._kWrongPassword, context: context);
        break;
      case 'success':
        Navigator.pushNamed(context, HomeScreen.kHomeRoute);
        break;
      default:
        showSnackBar(msg: widget._kDefaultError, context: context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    disposeFocusNodes();
    disposeTextControllers();
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
              String status = await MyFirebaseAuth.signInUser(
                  email: _emailController.text.trim(),
                  password: _passwordController.text.trim());
              print(status); 
              handleSignInExceptions(status);
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
                        'Sign In',
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
                        focusNode: _emailFocusNode,
                        prefixIcon: Icon(Icons.email,
                            color: getColorOnFocus(_emailFocusNode)),
                        onTap: () => _requestFocus(_emailFocusNode),
                        hintText: 'someone@emaill.com',
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
                        height: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                            children: [
                              TextSpan(text: 'Don\'t have an account? '),
                              TextSpan(
                                  text: 'Sign Up',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(
                                          context, SignUpScreen.kSignUpScreen);
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
}
