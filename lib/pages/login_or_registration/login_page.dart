import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_auth/elements/button.dart';
import 'package:learn_auth/elements/text_field.dart';
import 'package:learn_auth/pages/login_or_registration/restore_page.dart';
import 'package:learn_auth/pages/main_page.dart';
import 'package:learn_auth/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const LoginPage({super.key, required this.onClickedSignUp});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void snackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  signIn() async {
    if (emailController.text == '' || passwordController.text == '') {
      snackBar("Input email and password!");
    } else {
      try {
        setState(() {
          const Center(child: CircularProgressIndicator());
        });
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
        _fireStore.collection('users').doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'email': emailController.text,
        }, SetOptions(merge: true));

        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const MainPage()));
      } on FirebaseAuthException catch (e) {
        snackBar(e.message.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Messenger'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: ListView(
          primary: false,
          shrinkWrap: true,
          children: [
            Center(
              child: Text(
                'Login',
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            ProjectTextField(
                controller: emailController,
                showVisibleButton: false,
                label: 'Email or phone'),
            ProjectTextField(
                controller: passwordController,
                showVisibleButton: true,
                label: 'Password'),
            ProjectButton(
              method: signIn,
              label: 'Log in',
              textColor: Colors.black,
            ),
            //"continue with" text
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                child: Text(
                  'Continue with:',
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            //icon buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 16),
                  child: IconButton(
                    icon: Image.asset('assets/images/Google.png'),
                    onPressed: () async {
                      UserCredential user = await AuthService().signInWithGoogle();
                      if (user.user != null) {
                        final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
                        _fireStore.collection('users').doc(user.user!.uid).set({
                          'uid': user.user!.uid,
                          'email': user.user!.email,
                        }, SetOptions(merge: true));
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (_) => const MainPage()));
                      }
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 16),
                  child: IconButton(
                    icon: Image.asset('assets/images/Facebook.png'),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: RichText(
                  text: TextSpan(
                    text: 'Don\'t have account? ',
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignUp,
                        text: 'Register!',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: RichText(
                  text: TextSpan(
                    text: 'Forgot password? ',
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = (){Navigator.push(
                              context, MaterialPageRoute(
                              builder: (context) => const RestorePage())
                          );},
                        text: 'Restore',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
