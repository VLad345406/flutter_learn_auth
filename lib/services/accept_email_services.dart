import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn_auth/services/snack_bar.dart';

Future sendVerificationEmail(BuildContext context) async {
  try {
    final user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification();
  } catch (e) {
    snackBar(context, e.toString());
  }
}