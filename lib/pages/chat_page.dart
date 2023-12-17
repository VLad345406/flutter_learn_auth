import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:learn_auth/elements/avatar.dart';
import 'package:learn_auth/elements/text_field.dart';
import 'package:learn_auth/services/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;
  final String senderUserName;
  final String receiverUserName;

  const ChatPage(
      {super.key,
      required this.receiverUserEmail,
      required this.receiverUserID,
      required this.senderUserName,
      required this.receiverUserName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageEditingController =
      TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final ScrollController _scrollController = ScrollController();

  void sendMessage() async {
    if (_messageEditingController.text.isNotEmpty) {
      await _chatService.sendMessage(widget.receiverUserID,
          _messageEditingController.text, widget.senderUserName);
      _messageEditingController.clear();
    }
  }

  String receiverAvatarLink = '';

  Future<void> getReceiverUserData() async {
    final userId = widget.receiverUserID;
    final data =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    setState(() {
      receiverAvatarLink = data['image_link'];
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getReceiverUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Animate(child: Text(widget.receiverUserName).animate().fade()),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageItemList()),
          Animate(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ProjectTextField(
                      controller: _messageEditingController,
                      showVisibleButton: false,
                      label: '',
                    ),
                  ),
                  IconButton(
                    onPressed: sendMessage,
                    icon: const Icon(
                      Icons.send,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ).animate().fade(),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageItemList() {
    return StreamBuilder(
        stream: _chatService.getMessages(
            widget.receiverUserID, _firebaseAuth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error ${snapshot.error.toString()}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('Loading...'));
          }

          return Animate(
            child: ListView(
              controller: _scrollController,
              children: snapshot.data!.docs
                  .map((document) => _buildMessageItem(document))
                  .toList(),
            ).animate().moveY(begin: 1, end: 0).fade(),
          );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    _scrollToBottom();
    return Row(
      mainAxisAlignment: alignment == Alignment.centerRight
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        alignment == Alignment.centerLeft
            ? Padding(
                padding: const EdgeInsets.only(left: 16),
                child: ProjectUserAvatar(
                  userAvatarLink: receiverAvatarLink,
                  radius: 20,
                ),
              )
            : Container(),
        Container(
          alignment: alignment,
          child: Container(
            margin: const EdgeInsets.only(left: 16, top: 16, right: 16),
            padding:
                const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 100,
            ),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: (alignment == Alignment.centerRight)
                    ? const Radius.circular(20)
                    : const Radius.circular(0),
                bottomRight: (alignment == Alignment.centerLeft)
                    ? const Radius.circular(20)
                    : const Radius.circular(0),
              ),
            ),
            child: Column(
              crossAxisAlignment:
                  (data['senderId'] == _firebaseAuth.currentUser!.uid)
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
              children: [
                Text(
                  data['senderUserName'],
                  style: const TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w700),
                ),
                Text(data['message']),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
