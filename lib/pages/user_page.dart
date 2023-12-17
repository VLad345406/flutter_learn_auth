import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_auth/elements/avatar.dart';
import 'package:learn_auth/pages/change_password.dart';

import '../elements/button.dart';
import '../services/image_picker.dart';
import '../services/navigator_service.dart';
import '../services/user_page_services.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Future<void> getUserData() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final data =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    setState(() {
      userName = data['user_name'];
      userAvatarLink = data['image_link'];
    });
  }

  String userName = '';
  String userAvatarLink = '';

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    uploadImageToStorage(userName, image);
    await saveData(FirebaseAuth.instance.currentUser!.email.toString(),
        FirebaseAuth.instance.currentUser!.uid.toString(), userName, image);
    getUserData();
  }

  @override
  void initState() {
    super.initState();
    getUserData();
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
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: GestureDetector(
            onTap: selectImage,
            child: ProjectUserAvatar(
              userAvatarLink: userAvatarLink,
              radius: 50,
            ),
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
          method: () => navigatorPush(context, const ChangePassword()),
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
