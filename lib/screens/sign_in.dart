import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  static final kSignInScreen = 'kSignInScreen';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  FocusNode _emailFocusNode;
  FocusNode _passwordFocusNode;
  Color getColorOnFocus(FocusNode focusNode){
    return focusNode.hasFocus? Colors.deepPurpleAccent : Colors.grey;
  }

  void _requestFocus(FocusNode focusNode){
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          floatingActionButton: SizedBox(
            width: 70,
            height: 70,
            child: FittedBox(
              child: FloatingActionButton(
                child: Icon(Icons.login),
                backgroundColor: Colors.deepPurpleAccent,
                onPressed: null,

              ),
            ),
          ),
          body: Container(
            color: Colors.deepPurpleAccent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: Container(
                    color: Colors.deepPurpleAccent,
                    alignment: Alignment.centerLeft,
                    child: DefaultTextStyle(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: AnimatedTextKit(
                          repeatForever: true,
                          animatedTexts: [
                            TypewriterAnimatedText('The Typing Game', speed: Duration(milliseconds: 100))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
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
                          SizedBox(height: 20,),
                          TextFormField(
                            focusNode: _emailFocusNode,
                            onTap: () => _requestFocus(_emailFocusNode),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.email, color: getColorOnFocus(_emailFocusNode)),
                              hintText: 'someone@email.com',
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                color: getColorOnFocus(_emailFocusNode),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1, color: Colors.deepPurpleAccent)
                              )
                            ),
                          ),
                          SizedBox(height: 20,),
                          TextFormField(
                            focusNode: _passwordFocusNode,
                            onTap: () => _requestFocus(_passwordFocusNode),
                            obscureText: true,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.password,
                                    color: getColorOnFocus(_passwordFocusNode)),
                                hintText: 'password',
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                  color: getColorOnFocus(_passwordFocusNode),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1, color: Colors.deepPurpleAccent)
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}


