import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn_auth/elements/button.dart';
import 'package:learn_auth/pages/main_page.dart';

class WaitAcceptEmailPage extends StatefulWidget {
  const WaitAcceptEmailPage({super.key});

  @override
  State<WaitAcceptEmailPage> createState() => _WaitAcceptEmailPageState();
}

class _WaitAcceptEmailPageState extends State<WaitAcceptEmailPage> {
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      snackBar(e.toString());
    }
  }

  void snackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const MainPage()
      : Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Center(
                  child: Text(
                    'We have sent you a confirmation email\n'
                    'to the email address you provided.\n'
                    'Please confirm your e-mail address!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              ProjectButton(
                  method: sendVerificationEmail,
                  label: 'Resent Email',
                textColor: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: TextButton(
                  onPressed: () {
                    try {
                      FirebaseAuth.instance.signOut();
                    } catch (e) {
                      Navigator.pushAndRemoveUntil(
                          context, '/home' as Route<Object?>, (route) => false);
                    }
                  },
                  child: const Text(
                    'Cansel',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        );
}
