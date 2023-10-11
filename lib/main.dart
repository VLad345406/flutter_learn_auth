import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learn_auth/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const LearnAuth());
}

class LearnAuth extends StatelessWidget {
  const LearnAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learn auth',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      //initialRoute: '/',
      /*routes: {
        '/home': (context) => const HomePage(),
        //'/login': (context) => const LoginPage(),
        //'/registration': (context) => const RegistrationPage(),
        '/main': (context) => const MainPage(),
        //'/wait_accept': (context) => const WaitAcceptEmailPage(),
      },*/
      home: Scaffold(
        body: AuthService().handleAuthState(),
      ),
    );
  }
}
