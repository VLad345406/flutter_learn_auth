import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:learn_auth/pages/login_or_registration/login_or_registration_builder.dart';
import 'package:learn_auth/services/snack_bar.dart';

import '../../elements/button.dart';
import '../../elements/text_field.dart';
import '../main_page.dart';

class InputUserNamePage extends StatefulWidget {
  const InputUserNamePage({super.key});

  @override
  State<InputUserNamePage> createState() => _InputUserNamePageState();
}

class _InputUserNamePageState extends State<InputUserNamePage> {
  final _userNameController = TextEditingController();

  addInfo() async {
    if (_userNameController.text.isEmpty) {
      snackBar(context, 'Input information');
    } else {
      final FirebaseFirestore fireStore = FirebaseFirestore.instance;
      fireStore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'email': FirebaseAuth.instance.currentUser!.email,
        'user_name': _userNameController.text,
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const MainPage(),
        ),
      );
    }
  }

  Future<void> removeAccount() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.disconnect();

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      user?.delete();
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginOrRegisterBuilder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Messenger'),
        centerTitle: true,
        leading: IconButton(
          onPressed: removeAccount,
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Add information',
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: 40,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          ProjectTextField(
            controller: _userNameController,
            showVisibleButton: false,
            label: 'User name',
          ),
          ProjectButton(
            method: addInfo,
            label: 'Save',
            textColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
