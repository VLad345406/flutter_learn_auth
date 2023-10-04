import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_auth/elements/button.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User page',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'Signed in as',
          style: GoogleFonts.timmana(
            fontSize: 20,
          ),
        ),
        Text(
          user.email!,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        ProjectButton(
          method: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (Route<dynamic> route) => false);
          },
          label: 'Log out',
          textColor: Colors.black,
        ),
        ProjectButton(
          method: () async {
            FirebaseAuth.instance.authStateChanges().listen((User? user) {
              user?.delete();
            });
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (Route<dynamic> route) => false);
          },
          label: 'Remove account',
          textColor: Colors.red,
        ),
      ]),
    );
  }
}
