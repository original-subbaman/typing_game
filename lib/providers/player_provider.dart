
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thumbing/providers/auth_provider.dart';

import '../firebase/firebase_constants.dart';
import '../model/player.dart';
import 'firestore_provider.dart';

final playerProvider = StreamProvider<Player>((ref) {
  final userStream = ref.watch(authStateProvider);
  final firestore = ref.read(firestoreProvider);
  var user = userStream.value;
  if (user != null) {
    var playerStream = firestore.getUser(user.uid);
    return playerStream.map((doc){
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return new Player(
        uid: data[UID],
        fullName: data[FULL_NAME],
        email: data[EMAIL],
        leagueScore: data[LEAGUE_SCORE],
        userName: data[USER_NAME],
        acc: data[ACC],
        wpm: data[WPM],
        bestRank: data[BEST_RANK],
      );
    });
  }else{
    return Stream.empty();
  }
});