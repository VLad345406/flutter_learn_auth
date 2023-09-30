import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../pages/home_page.dart';
import '../pages/wait_accept_email_page.dart';

class AuthService {
  handleAuthState() {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const WaitAcceptEmailPage();
          }
          else {
            return const HomePage();
          }
        },
      ),
    );
  }

  signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
      scopes: <String>["email"]).signIn();

    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}