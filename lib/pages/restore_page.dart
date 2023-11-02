import 'package:flutter/material.dart';

import '../elements/button.dart';
import '../elements/text_field.dart';

class RestorePage extends StatelessWidget {
  const RestorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Messenger'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProjectTextField(
              controller: emailController,
              showVisibleButton: false,
              label: 'Email'
          ),
          ProjectButton(
            method: (){
              if (emailController.text == "") {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Input email adress'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            label: 'Next',
            textColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
