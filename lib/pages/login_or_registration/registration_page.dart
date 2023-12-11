import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_auth/elements/button.dart';
import 'package:learn_auth/elements/logo_image.dart';

import '../../elements/text_field.dart';
import '../../services/registration.dart';

class RegistrationPage extends StatefulWidget {
  final VoidCallback onClickedSignIn;

  const RegistrationPage({super.key, required this.onClickedSignIn});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isWait = false;

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
        child: Animate(
          child: ListView(
            shrinkWrap: true,
            primary: false,
            children: [
              const LogoImage(),
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
              ProjectTextField(
                  controller: userNameController,
                  showVisibleButton: false,
                  label: 'User name'),
              ProjectTextField(
                  controller: passwordController,
                  showVisibleButton: true,
                  label: 'Password'),
              ProjectTextField(
                  controller: confirmPasswordController,
                  showVisibleButton: true,
                  label: 'Confirm password'),
              ProjectButton(
                method: () {
                  registration(
                    context,
                    emailController,
                    userNameController,
                    passwordController,
                    confirmPasswordController,
                  );
                },
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
          ).animate()
              .fadeIn(duration: const Duration(milliseconds: 500)),
        ),
      ),
    );
  }
}
