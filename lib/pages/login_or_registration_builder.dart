import 'package:flutter/material.dart';
import 'package:learn_auth/pages/login.dart';
import 'package:learn_auth/pages/registration.dart';

class LoginOrRegisterBuilder extends StatefulWidget {
  const LoginOrRegisterBuilder({super.key});

  @override
  State<LoginOrRegisterBuilder> createState() => _LoginOrRegisterBuilderState();
}

class _LoginOrRegisterBuilderState extends State<LoginOrRegisterBuilder> {
  bool isLogin = true;

  /*route(classRoute) {
    return classRoute;
  }*/

  @override
  Widget build(BuildContext context) =>
    isLogin ? LoginPage(onClickedSignUp: toggle) :
    RegistrationPage(onClickedSignIn: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}
