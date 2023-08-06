import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future registration() async {
    if (emailController.text == '' ||
        passwordController.text == '' ||
        confirmPasswordController.text == '') {
      print('Error!');
    } else if (passwordController.text != confirmPasswordController.text) {
      print('Wrong confirm password');
    } else {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        Navigator.pushNamedAndRemoveUntil(
            context, '/main', (Route<dynamic> route) => false);
      }
      catch (e) {
        print('Error registration!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registration',
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
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
            ),
            child: TextFormField(
              controller: confirmPasswordController,
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
                labelText: 'Confirm password',
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
            height: 60,
            width: screenWidth - 32,
            margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
            decoration: BoxDecoration(
              border: Border.all(width: 2),
              color: Colors.black,
            ),
            child: TextButton(
              onPressed: registration,
              /*(){
                Navigator.pushNamedAndRemoveUntil(context, '/main', (Route<dynamic> route) => false);
              },*/
              child: Text(
                'Registration',
                style: GoogleFonts.roboto(
                  color: Colors.white,
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
