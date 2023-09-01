import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utility/colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static String kForgotPasswordScreen = "kForgotPassword";

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late TextEditingController _emailController;

  Future _resetPassword(context) async {
    showDialog(context: context, barrierDismissible: false, builder: (context) => Center(child: CircularProgressIndicator(),));
    try{
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim()); 
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password Reset Email Sent")));
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch(e){
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${e.message}")));
      Navigator.of(context).pop();
    }


    
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
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
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Enter your email id",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: "Email"),
                    controller: _emailController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? "Enter a valid email"
                            : null,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  ElevatedButton(
                    onPressed: () => _resetPassword(context),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        "Reset Password",
                        style: TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(kLightBlueAccent),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
