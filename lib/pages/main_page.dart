import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn_auth/pages/user_page.dart';

import 'chat_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    //final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Chats',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(
                icon: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UserPage()),
                  );
                })
          ],
        ),
        //body: _buildUserList(),
        body: Container(),
    );
  }

  Widget _buildUserList(DocumentSnapshot document) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error!");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading...");
          }

          return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => _buildUserListItem(doc))
                .toList(),
          );
        });
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (_auth.currentUser!.email != data['email']) {
      return ListTile(
        title: data['email'],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatPage(
                      receiverUserEmail: data['email'],
                      receiverUserID: data['uid'],
                    )),
          );
        },
      );
    }
    else {
      return const Text("Error!");
    }
  }
}
