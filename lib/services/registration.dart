import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:learn_auth/services/password_rules.dart';
import 'package:learn_auth/services/snack_bar.dart';

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
    if (await checkUsernameExists(userNameController.text)) {
      snackBar(context, 'This user name is already exist!');
    }
    else {
      bool checkRules = checkPasswordRules(passwordController.text);
      if (checkRules) {
        try {
          UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
          final FirebaseFirestore fireStore = FirebaseFirestore.instance;
          fireStore.collection('users').doc(userCredential.user!.uid).set({
            'uid': userCredential.user!.uid,
            'email': emailController.text,
            'user_name': userNameController.text,
            'image_link': '',
          });
        } on FirebaseAuthException catch (e) {
          snackBar(context, e.message.toString());
        }
      } else {
        snackBar(context,
            'Password should have 7 characters with at least one capital letter!');
      }
    }
  }
}

Future<bool> checkUsernameExists(String username) async {
  bool exists = false;

  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .where('user_name', isEqualTo: username)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      exists = true;
    }
  } catch (e) {
    if (kDebugMode) {
      print('');
    }
  }

  return exists;
}
