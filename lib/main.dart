import 'package:flutter/material.dart';
import 'package:learn_auth/pages/home_page.dart';
import 'package:learn_auth/pages/login.dart';
import 'package:learn_auth/pages/main_page.dart';
import 'package:learn_auth/pages/registration.dart';

void main() => runApp(LearnAuth());

class LearnAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Learn auth',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/registration': (context) => const RegistrationPage(),
        '/main': (context) => const MainPage(),
      },
      //home: const HomePage(),
    );
  }
}
