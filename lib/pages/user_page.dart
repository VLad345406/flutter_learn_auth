import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:learn_auth/pages/login_or_registration/login_or_registration_builder.dart';

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
          method: () {},
          label: 'Change password',
          textColor: Colors.black,
        ),
        ProjectButton(
          method: () async {
            try {
              GoogleSignIn googleSignIn = GoogleSignIn();
              await googleSignIn.disconnect();
            } catch (e) {
              if (kDebugMode) {
                print(e);
              }
            }
            await FirebaseAuth.instance.signOut();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginOrRegisterBuilder()),
                (route) => false);
          },
          label: 'Log out',
          textColor: Colors.red,
        ),
        ProjectButton(
          method: () async {
            try {
              GoogleSignIn googleSignIn = GoogleSignIn();
              await googleSignIn.disconnect();
            } catch (e) {
              if (kDebugMode) {
                print(e);
              }
            }
            FirebaseAuth.instance.authStateChanges().listen((User? user) {
              user?.delete();
            });
            /*final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
            _fireStore.collection('users').doc(user.user!.uid).set({
              'uid': user.user!.uid,
              'email': user.user!.email,
            }, SetOptions(merge: true));
            _fireStore.collection('users').doc(user.user!.uid).delete();*/
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const LoginOrRegisterBuilder()));
          },
          label: 'Remove account',
          textColor: Colors.red,
        ),
      ]),
    );
  }
}
