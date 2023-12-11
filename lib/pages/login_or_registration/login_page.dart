import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_auth/elements/button.dart';
import 'package:learn_auth/elements/logo_image.dart';
import 'package:learn_auth/elements/text_field.dart';
import 'package:learn_auth/pages/login_or_registration/restore_page.dart';
import 'package:learn_auth/services/navigator_service.dart';

import '../../services/sigh_in.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const LoginPage({super.key, required this.onClickedSignUp});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
            primary: false,
            shrinkWrap: true,
            children: [
              const LogoImage(),
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
                  label: 'Email'),
              ProjectTextField(
                  controller: passwordController,
                  showVisibleButton: true,
                  label: 'Password'),
              ProjectButton(
                method: () {
                  signIn(context, emailController, passwordController);
                },
                label: 'Log in',
                textColor: Colors.black,
              ),
              //"continue with" text
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
                            ..onTap = () =>
                                navigatorPush(context, const RestorePage()),
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
          ).animate().fadeIn(duration: const Duration(milliseconds: 500)),
        ),
      ),
    );
  }
}
