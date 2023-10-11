import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_auth/elements/button.dart';
import 'package:learn_auth/elements/text_field.dart';
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
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        Navigator.pushNamed(context, '/wait_accept');
      } catch (e) {
        snackBar(e.toString());
      }
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
                  onPressed: AuthService().signInWithGoogle,
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
          RichText(
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
        ],
      ),
    );
  }
}
