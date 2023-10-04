import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_auth/elements/button.dart';
import 'package:learn_auth/elements/text_field.dart';
import 'package:learn_auth/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  signIn() async {
    if (emailController.text == '' || passwordController.text == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Input email and password!"),
          behavior: SnackBarBehavior.floating,
        ),
      );
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProjectTextField(
            controller: emailController,
            showVisibleButton: false,
            label: 'Email or phone'
          ),
          ProjectTextField(
            controller: passwordController,
            showVisibleButton: true,
            label: 'Password'
          ),
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
        ],
      ),
    );
  }
}
