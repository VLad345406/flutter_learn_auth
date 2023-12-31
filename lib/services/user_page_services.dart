import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:learn_auth/services/navigator_service.dart';

import '../pages/login_or_registration/login_or_registration_builder.dart';

void logOut(BuildContext context) async {
  try {
    GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.disconnect();
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
  await FirebaseAuth.instance.signOut();
  navigatorPushReplacement(
    context,
    const LoginOrRegisterBuilder(),
  );
}

void removeAccount(BuildContext context) async {
  try {
    GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.disconnect();
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
  //remove user info from database
  final userId = FirebaseAuth.instance.currentUser!.uid;
  final data =
      await FirebaseFirestore.instance.collection('users').doc(userId).get();
  try {
    await FirebaseStorage.instance.ref()
        .child('avatars/${data['user_name']}')
        .delete();
  } catch (e) {
    if (kDebugMode) {
      print("User don't have avatar!");
    }
  }
  await FirebaseFirestore.instance.collection('users').doc(userId).delete();
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    user?.delete();
  });
  navigatorPushReplacement(
    context,
    const LoginOrRegisterBuilder(),
  );
}
