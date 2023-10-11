import 'package:flutter/material.dart';
import 'package:learn_auth/pages/login.dart';
import 'package:learn_auth/pages/registration.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
