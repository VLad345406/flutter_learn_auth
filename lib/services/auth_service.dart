import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../pages/login_or_registration/login_or_registration_builder.dart';
import '../pages/main_page.dart';

class AuthService {
  handleAuthState() {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong!'));
          }
          else if (snapshot.hasData) {
            /*if (!FirebaseAuth.instance.currentUser!.emailVerified) {
              return const WaitAcceptEmailPage();
            }*/
            //else {
              return const MainPage();
            //}
          }
          else {
            return const LoginOrRegisterBuilder();
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