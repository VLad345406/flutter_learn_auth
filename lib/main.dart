import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learn_auth/pages/home_page.dart';
import 'package:learn_auth/pages/login.dart';
import 'package:learn_auth/pages/main_page.dart';
import 'package:learn_auth/pages/registration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const LearnAuth());
}

class LearnAuth extends StatelessWidget {
  const LearnAuth({super.key});

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