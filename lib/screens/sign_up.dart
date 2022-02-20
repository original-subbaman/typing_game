import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thumbing/screens/home_screen.dart';
import 'package:thumbing/screens/sign_in.dart';
import 'package:thumbing/utility/firebase_authentication.dart';
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
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController _userNameController;
  TextEditingController _passwordController;
  TextEditingController _emailController;

  Color getColorOnFocus(FocusNode focusNode) {
    return focusNode.hasFocus ? Colors.deepPurpleAccent : Colors.grey;
  }

  void _requestFocus(FocusNode focusNode) {
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  void handleSignUpExceptions(String status){
    switch(status){
      case "weak-password":
      //show weak password toast
        showSnackBar(msg: widget.kWeakPassword, context: context);
        break;
      case "email-already-in-use":
      //show email already in use toast
        showSnackBar(msg: widget.kEmailAlreadyInUse, context: context);
        break;
      case "success":
      //transfer to home screen
        Navigator.pushNamed(context, HomeScreen.kHomeRoute);
        break;
      case "invalid-email":
        showSnackBar(msg: widget.kInvalidEmail, context: context);
        break;
      default:
      //show error toast
        showSnackBar(msg: widget.kDefaultError, context: context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _usernameFocusNode = FocusNode();
    _userNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    disposeFocusNodes();
    disposeControllers();
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
              String status = await FirebaseAuthentication.signUpUser(email: _emailController.text.trim(), password: _passwordController.text.trim());
              print(status);
              handleSignUpExceptions(status);
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
  }

  void disposeControllers() {
    _userNameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
  }


}
