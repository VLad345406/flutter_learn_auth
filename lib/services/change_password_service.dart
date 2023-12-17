import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn_auth/services/password_rules.dart';
import 'package:learn_auth/services/snack_bar.dart';

void changePassword(
  BuildContext context,
  TextEditingController oldPassword,
  TextEditingController newPassword,
  TextEditingController repeatNewPassword,
) async {
  if (oldPassword.text.isEmpty ||
      newPassword.text.isEmpty ||
      repeatNewPassword.text.isEmpty) {
    snackBar(context, 'Not enough information!');
  } else {
    bool checkOldPassword = false;
    final AuthCredential credential;
    final user = FirebaseAuth.instance.currentUser;
    try {
      credential = EmailAuthProvider.credential(
        email: user!.email.toString(),
        password: oldPassword.text,
      );
      await user.reauthenticateWithCredential(credential);
      checkOldPassword = true;
    } on Exception {
      snackBar(context, 'Wrong old password!');
    }
    if (checkOldPassword) {
      if (newPassword.text != repeatNewPassword.text) {
        snackBar(context, 'New password and repeat not equal!');
      }
      else {
        if (oldPassword.text == newPassword.text) {
          snackBar(context, "New password can`t be equal old password!");
        }
        else {
          bool checkRules = checkPasswordRules(newPassword.text);
          if (checkRules) {
            await user?.updatePassword(newPassword.text);
            Navigator.pop(context);
            snackBar(context, 'Success change!');
          } else {
            snackBar(context,
                'Password should have 7 characters with at least one capital letter!');
          }
        }
      }
    }
  }
}
