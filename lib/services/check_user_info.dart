import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn_auth/pages/login_or_registration/input_user_name_page.dart';

import '../pages/main_page.dart';

class CheckUserInfo extends StatefulWidget {
  const CheckUserInfo({super.key});

  @override
  State<CheckUserInfo> createState() => _CheckUserInfoState();
}

class _CheckUserInfoState extends State<CheckUserInfo> {
  bool hasData = false;

  void checkData() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen(
          (snapshot) {
        if (snapshot.exists) {
          hasData = true;
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    checkData();
  }

  @override
  Widget build(BuildContext context) {
    return hasData ? const MainPage() : const InputUserNamePage();
  }
}