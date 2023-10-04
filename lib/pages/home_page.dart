import 'package:flutter/material.dart';
import 'package:learn_auth/elements/button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  route(classRoute) {
    return classRoute;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Learn auth'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProjectButton(
            method: () => Navigator.pushNamed(context, '/login'),
            label: 'Log in',
            textColor: Colors.black,
          ),
          ProjectButton(
            method: () => Navigator.pushNamed(context, '/registration'),
            label: 'Registration',
            textColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
