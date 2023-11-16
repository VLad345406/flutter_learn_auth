import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../elements/button.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

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
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: CircleAvatar(
            radius: 50,
          ),
        ),
        Text(
          user.email!,
          style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        ProjectButton(
          method: ()  {},
          label: 'Change password',
          textColor: Colors.black,
        ),
        ProjectButton(
          method: () async {
            GoogleSignIn googleSignIn = GoogleSignIn();
            await FirebaseAuth.instance.signOut();
            await googleSignIn.disconnect();
          },
          label: 'Log out',
          textColor: Colors.red,
        ),
        ProjectButton(
          method: () async {
            FirebaseAuth.instance.authStateChanges().listen((User? user) {
              user?.delete();
            });
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', (Route<dynamic> route) => false);
          },
          label: 'Remove account',
          textColor: Colors.red,
        ),
      ]),
    );
  }
}
