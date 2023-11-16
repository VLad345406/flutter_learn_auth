import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_auth/elements/button.dart';
import 'package:learn_auth/pages/login_or_registration/wait_accept_email_page.dart';

import '../../elements/text_field.dart';

class RegistrationPage extends StatefulWidget {
  final VoidCallback onClickedSignIn;

  const RegistrationPage({super.key, required this.onClickedSignIn});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future registration() async {
    if (emailController.text == '' ||
        passwordController.text == '' ||
        confirmPasswordController.text == '') {
      snackBar('Please, input data');
    } else if (passwordController.text != confirmPasswordController.text) {
      snackBar('Wrong confirm password!');
    } else {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        toggle();
        //Navigator.pushNamed(context, '/wait_accept');
      } on FirebaseAuthException catch (e) {
        snackBar(e.message.toString());
      }
    }
  }

  void snackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  bool isWait = false;

  @override
  Widget build(BuildContext context) => !isWait
      ? Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text('Messenger'),
            centerTitle: true,
            elevation: 0,
          ),
          body: Center(
            child: ListView(
              shrinkWrap: true,
              primary: false,
              children: [
                Center(
                  child: Text(
                    'Registration',
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
                    label: 'Email'),
                /*ProjectTextField(
                controller: phoneController,
                showVisibleButton: false,
                label: 'Phone number'
            ),*/
                ProjectTextField(
                    controller: passwordController,
                    showVisibleButton: true,
                    label: 'Password'),
                ProjectTextField(
                    controller: confirmPasswordController,
                    showVisibleButton: true,
                    label: 'Confirm password'),
                ProjectButton(
                  method: registration,
                  label: 'Registration',
                  textColor: Colors.black,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: RichText(
                      text: TextSpan(
                        text: 'Have account? ',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = widget.onClickedSignIn,
                            text: 'Login!',
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
        )
      : WaitAcceptEmailPage(onClickedCansel: toggle);

  void toggle() => setState(() => isWait = !isWait);
}
