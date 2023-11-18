import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thumbing/firebase/firebase_firestore.dart';

final firestoreProvider = StateProvider<MyCloudFirestore>(
    (ref) => MyCloudFirestore(FirebaseFirestore.instance));
