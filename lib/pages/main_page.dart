import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:learn_auth/pages/user_page.dart';
import 'package:learn_auth/services/navigator_service.dart';

import 'chat_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> getUserName() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final data =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
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
        title: Animate(
          child: Text(
            'Chats $userName',
            style: const TextStyle(
              color: Colors.white,
            ),
          ).animate().fade(),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
        actions: <Widget>[
          Animate(
            child: IconButton(
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              onPressed: () => navigatorPush(context, const UserPage()),
            ).animate().fade(),
          )
        ],
      ),
      body: _buildUserList(),
      //body: Container(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error!");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text("Loading..."));
        }

        return Animate(
          child: ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => _buildUserListItem(doc))
                .toList().animate().fade().moveY(),
          ),
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (_auth.currentUser!.email != data['email']) {
      String receiverUserName = data['user_name'];
      return ListTile(
        title: Text(receiverUserName),
        onTap: () {
          navigatorPush(
            context,
            ChatPage(
              receiverUserEmail: data['email'],
              receiverUserID: data['uid'],
              senderUserName: userName,
              receiverUserName: receiverUserName,
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
