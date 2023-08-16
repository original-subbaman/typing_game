
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thumbing/screens/error_screen.dart';
import 'package:thumbing/screens/home_screen.dart';
import 'package:thumbing/screens/sign_in.dart';

final authenticationProvider = Provider((ref){
  return FirebaseAuth.instance;
});

final authStateProvider = StreamProvider((ref){
 return ref.read(authenticationProvider).authStateChanges();
});

class Wrapper extends ConsumerStatefulWidget {
  static final kLandingPage = 'Landing Page';
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends ConsumerState<Wrapper> {



  @override
  Widget build(BuildContext context) {
    final _authState = ref.watch(authStateProvider);
    return _authState.when(data: (data){
      if(data != null){
        return HomeScreen();
      }else{
        return SignInScreen();
      }
    }, error: (e, trace) => ErrorScreen(), loading: () => CircularProgressIndicator());

  }
}
