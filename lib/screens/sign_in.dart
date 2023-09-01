import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:thumbing/screens/forgot_password.dart';
import 'package:thumbing/screens/home_screen.dart';
import 'package:thumbing/screens/sign_up.dart';
import 'package:thumbing/utility/constants.dart';
import 'package:thumbing/widgets/input_form_field.dart';
import '../firebase/firebase_authentication.dart';
import '../utility/colors.dart';

class SignInScreen extends StatefulWidget {
  static final kSignInScreen = 'kSignInScreen';
  final _kUserNotFound = 'No user found for this email.';
  final _kWrongPassword = 'Wrong password. Please try again.';
  final _kDefaultError = 'Error logging in. Please try again.';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;
  FirebaseAuth auth = FirebaseAuth.instance;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  Color getColorOnFocus(FocusNode focusNode) {
    return focusNode.hasFocus ? kLightBlueAccent : Colors.grey;
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

  void _showProgressDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Future<String> _signInUserWithEmailPassword() async {
    String status = await MyFirebaseAuth.signInUser(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim())
        .whenComplete(() {
      Navigator.of(context).pop();
    });
    return status;
  }

  void _signInUserWithGoogleSignIn() async{
    String status = await MyFirebaseAuth.signInWithGoogle();
    print("Sign in status: " + status);
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
        Navigator.popAndPushNamed(context, HomeScreen.kHomeRoute);
        break;
      default:
        showSnackBar(msg: widget._kDefaultError, context: context);
    }
  }

  Text _loginInfoText() {
    return Text(
      'Log in with your email id to get started',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w300,
        fontSize: 20.0,
      ),
      textAlign: TextAlign.center,
    );
  }

  GestureDetector _forgotText(BuildContext context) {
    return GestureDetector(
      child: Text(
        'Forgot Password?',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          decoration: TextDecoration.underline,
        ),
        textAlign: TextAlign.right,
      ),
      onTap: () => Navigator.pushNamed(context, ForgotPasswordScreen.kForgotPasswordScreen),
    );
  }

  RichText _signUpText() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
        children: [
          TextSpan(text: 'Don\'t have an account? '),
          TextSpan(
            text: 'Sign Up',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.popAndPushNamed(context, SignUpScreen.kSignUpScreen);
              },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    disposeFocusNodes();
    disposeTextControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FittedBox(
          child: FloatingActionButton(
            child: Icon(Icons.login),
            backgroundColor: kLightBlueAccent,
            onPressed: () async {
              dismissKeyboard();
              _showProgressDialog();
              String status = await _signInUserWithEmailPassword();
              handleSignInExceptions(status);
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
            vertical: 120.0,
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
                    Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 42,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    _loginInfoText(),
                    SizedBox(
                      height: 20,
                    ),
                    InputFormField(
                      focusNode: _emailFocusNode,
                      prefixIcon: Icon(Icons.email,
                          color: getColorOnFocus(_emailFocusNode)),
                      onTap: () => _requestFocus(_emailFocusNode),
                      hintText: 'someone@emaill.com',
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
                      height: 20,
                    ),
                    _forgotText(context),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "or Sign in With",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: ()=> print("tapped"),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.symmetric(horizontal: 120),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.grey[300],
                        ),
                        child: Image.asset(
                          "assets/icons/google_icon.png",
                          height: 50,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _signUpText(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    ));
  }


}
