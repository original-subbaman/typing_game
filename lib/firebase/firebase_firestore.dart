import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:thumbing/firebase/firebase_constants.dart';

class MyCloudFirestore {

  static Future<String> addUser(
      {String uid, String username, String fullName, String email}) async {
    CollectionReference users = FirebaseFirestore.instance.collection(kUserCollection);
    String status;
    User user = await users
        .doc(uid)
        .set({'uid': uid, 'user_name': username, 'full_name': fullName, 'email': email})
        .then((value){
          print('User Added');
          status = "success";
        })
        .catchError((error) {
          print('Error adding user: $error');
          status = error;
        });

    return status;
  }
}
