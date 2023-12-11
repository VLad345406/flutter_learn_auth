import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../elements/button.dart';
import '../../elements/logo_image.dart';
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
        centerTitle: true,
      ),
      body: Center(
        child: Animate(
          child: ListView(
            primary: false,
            shrinkWrap: true,
            children: [
              const LogoImage(),
              Center(
                child: Text(
                  'Restore password',
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
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
          ).animate().fadeIn(duration: const Duration(milliseconds: 500)),
        ),
      ),
    );
  }
}
