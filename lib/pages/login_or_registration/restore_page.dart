import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../elements/button.dart';
import '../../elements/text_field.dart';

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

  void snackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future restorePassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      snackBar('Password restore link sent! Check your email!');
    }on FirebaseAuthException catch (e) {
      snackBar(e.message.toString());
      /*showDialog(context: context, builder: (context) {
        return AlertDialog(
          content: Text(e.message.toString()),
        );
      });*/
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
