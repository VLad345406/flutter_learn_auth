import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_auth/elements/button.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
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
        Button(
            width: screenWidth - 32,
            left: 16,
            right: 16,
            top: 16,
            bottom: 0,
            method: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (Route<dynamic> route) => false);
            },
            label: 'Log out'),
        /*Container(
          height: 50,
          width: screenWidth - 32,
          margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
          decoration: BoxDecoration(
            border: Border.all(width: 2),
          ),
          child: TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (Route<dynamic> route) => false);
            },
            child: Text(
              'Log out',
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),*/
        Button(
            width: screenWidth - 32,
            left: 16,
            right: 16,
            top: 16,
            bottom: 0,
            method: () async {
              FirebaseAuth.instance.authStateChanges().listen((User? user) {
                user?.delete();
              });
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (Route<dynamic> route) => false);
            },
            label: 'Log out'),
        /*Container(
          height: 50,
          width: screenWidth - 32,
          margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
          decoration: BoxDecoration(
            border: Border.all(width: 2),
          ),
          child: TextButton(
            onPressed: () async {
              FirebaseAuth.instance.authStateChanges().listen((User? user) {
                user?.delete();
              });
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (Route<dynamic> route) => false);
            },
            child: Text(
              'Remove account',
              style: GoogleFonts.roboto(
                color: Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),*/
      ]),
    );
  }
}
