import 'package:flutter/material.dart';
import 'package:learn_auth/elements/button.dart';
import 'package:learn_auth/elements/text_field.dart';

import '../services/change_password_service.dart';

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
              method: () => changePassword(
                context,
                oldPassword,
                newPassword,
                repeatNewPassword,
              ),
              label: 'Save',
              textColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
