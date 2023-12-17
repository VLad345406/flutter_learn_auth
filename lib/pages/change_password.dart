import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn_auth/elements/button.dart';
import 'package:learn_auth/elements/text_field.dart';
import 'package:learn_auth/services/snack_bar.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController oldPassword = TextEditingController();
    TextEditingController newPassword = TextEditingController();
    TextEditingController repeatNewPassword = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Change password',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: ListView(
          primary: false,
          shrinkWrap: true,
          children: [
            ProjectTextField(
              controller: oldPassword,
              showVisibleButton: true,
              label: 'Old password',
            ),
            ProjectTextField(
              controller: newPassword,
              showVisibleButton: true,
              label: 'New password',
            ),
            ProjectTextField(
              controller: repeatNewPassword,
              showVisibleButton: true,
              label: 'Repeat new password',
            ),
            ProjectButton(
              method: () async {
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
                    } else {
                      await user?.updatePassword(newPassword.text);
                      Navigator.pop(context);
                      snackBar(context, 'Success change!');
                    }
                  }
                }
              },
              label: 'Save',
              textColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
