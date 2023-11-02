import 'package:flutter/material.dart';
import 'package:learn_auth/pages/login_or_registration/login_page.dart';
import 'package:learn_auth/pages/login_or_registration/registration_page.dart';

class LoginOrRegisterBuilder extends StatefulWidget {
  const LoginOrRegisterBuilder({super.key});

  @override
  State<LoginOrRegisterBuilder> createState() => _LoginOrRegisterBuilderState();
}

class _LoginOrRegisterBuilderState extends State<LoginOrRegisterBuilder> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) =>
    isLogin ? LoginPage(onClickedSignUp: toggle) :
    RegistrationPage(onClickedSignIn: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}
