import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thumbing/firebase/firebase_firestore.dart';
import 'package:thumbing/model/leaderboard_item.dart';

/// Provider to expose an instance of the MyCloudFirestore class
/// that holds all methods related to Firestore database use cases.
final firestoreProvider = StateProvider<MyCloudFirestore>(
    (ref) => MyCloudFirestore(FirebaseFirestore.instance));

/// This method returns a stream of QuerySnapshot related to the
/// 'league' collection in Firestore.
final leaderboardProvider = StreamProvider<List<LeaderboardItem>>((ref) {
  final firestoreRef = ref.read(firestoreProvider);
  return firestoreRef.getLeaderboard();
});
