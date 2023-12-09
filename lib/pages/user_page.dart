import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../elements/button.dart';
import '../services/user_page_services.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Future<void> getUserName () async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final data = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    setState(() {
      userName = data['user_name'];
    });
  }
  String userName = '';

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User page',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: CircleAvatar(
            radius: 50,
          ),
        ),
        Text(
          userName,
          style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        ProjectButton(
          method: () {},
          label: 'Change password',
          textColor: Colors.black,
        ),
        ProjectButton(
          method: () => logOut(context),
          label: 'Log out',
          textColor: Colors.red,
        ),
        ProjectButton(
          method: () => removeAccount(context),
          label: 'Remove account',
          textColor: Colors.red,
        ),
      ]),
    );
  }
}
