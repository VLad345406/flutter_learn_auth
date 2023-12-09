import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn_auth/pages/login_or_registration/wait_accept_email_page.dart';
import 'package:learn_auth/services/snack_bar.dart';

import 'navigator_service.dart';

Future registration(
  BuildContext context,
  TextEditingController emailController,
  TextEditingController userNameController,
  TextEditingController passwordController,
  TextEditingController confirmPasswordController,
) async {
  if (emailController.text == '' ||
      userNameController.text == '' ||
      passwordController.text == '' ||
      confirmPasswordController.text == '') {
    snackBar(context, 'Please, input data');
  } else if (passwordController.text != confirmPasswordController.text) {
    snackBar(context, 'Wrong confirm password!');
  } else {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      final FirebaseFirestore fireStore = FirebaseFirestore.instance;
      navigatorPushReplacement(context, const WaitAcceptEmailPage());
      /*Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const WaitAcceptEmailPage(),
        ),
      );*/
      fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': emailController.text,
        'user_name': userNameController.text,
      });
      //Navigator.pushNamed(context, '/wait_accept');
    } on FirebaseAuthException catch (e) {
      snackBar(context, e.message.toString());
    }
  }
}
