import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:learn_auth/pages/main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
            ),
            child: TextFormField(
              controller: emailController,
              onChanged: (value) {},
              enableSuggestions: false,
              autocorrect: false,
              style: GoogleFonts.roboto(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
              ),
              decoration: const InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                  borderSide: BorderSide(
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                  borderSide: BorderSide(
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
            ),
            child: TextFormField(
              controller: passwordController,
              onChanged: (value) {},
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              style: GoogleFonts.roboto(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
              ),
              decoration: const InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                  borderSide: BorderSide(
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                  borderSide: BorderSide(
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            width: screenWidth - 32,
            margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
            decoration: BoxDecoration(
              border: Border.all(width: 2),
            ),
            child: TextButton(
              onPressed: signIn,
              /*(){
                Navigator.pushNamedAndRemoveUntil(context, '/main', (Route<dynamic> route) => false);
              },*/
              child: Text(
                'Log in',
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
