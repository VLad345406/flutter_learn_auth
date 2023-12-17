import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn_auth/services/navigator_service.dart';
import 'package:learn_auth/services/snack_bar.dart';

import '../pages/main_page.dart';

signIn(BuildContext context, TextEditingController emailController,
    TextEditingController passwordController) async {
  if (emailController.text == '' || passwordController.text == '') {
    snackBar(context, "Input email and password!");
  } else {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final FirebaseFirestore fireStore = FirebaseFirestore.instance;
      fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': emailController.text,
      }, SetOptions(merge: true));

      // ignore: use_build_context_synchronously
      navigatorPushReplacement(context, const MainPage());
    } on FirebaseAuthException catch (e) {
      snackBar(context, e.message.toString());
    }
  }
}
