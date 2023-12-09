import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../elements/button.dart';
import '../../elements/text_field.dart';
import '../../services/snack_bar.dart';

class RestorePage extends StatefulWidget {
  const RestorePage({super.key});

  @override
  State<RestorePage> createState() => _RestorePageState();
}

class _RestorePageState extends State<RestorePage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future restorePassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      snackBar(context, 'Password restore link sent! Check your email!');
      Navigator.pop(context);
    }on FirebaseAuthException catch (e) {
      snackBar(context, e.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Messenger'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProjectTextField(
              controller: _emailController,
              showVisibleButton: false,
              label: 'Email'),
          ProjectButton(
            method: restorePassword,
            label: 'Next',
            textColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
