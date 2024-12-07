import 'package:chat_app/Config/My-Text_Field.dart';
import 'package:chat_app/FirebaseServices/Auth_Service.dart';
import 'package:chat_app/FirebaseServices/Chat_Service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'chat_bubble.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;

  const ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final messageController = TextEditingController();
  final chatService = ChatService();
  final authService = AuthServices();

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await chatService.sendMessage(widget.receiverID,
          messageController.text);
      setState(() {
        messageController.clear();


      });
    }
    scrollDown();
  }

  FocusNode myFocusNode = FocusNode() ;

  @override
  void initState() {
    super.initState();

    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        Future.delayed(
          const Duration(milliseconds: 500),
              () => scrollDown(),
        );
      }
    });
    Future.delayed(
      const Duration(milliseconds: 500),
          () => scrollDown(),
    );
    
  }

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  final ScrollController scrollController = ScrollController();

  void scrollDown() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );}
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      appBar: AppBar(
        title:  Text(widget.receiverEmail),
        backgroundColor: Colors.transparent,
        foregroundColor:Colors.grey,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(child: buildMessageList()),
          buildUserInput(),
        ],
      ),
    );
  }

  Widget buildMessageList() {
    final senderID = authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: chatService.getMessages(widget.receiverID, senderID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {}
          return ListView(
            controller: scrollController,
            children: snapshot.data!.docs
                .map((doc) => buildMessageItem(doc))
                .toList(),
          );
        });
  }

  Widget buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

// is current user
    bool isCurrentUser = data['senderID'] == authService.getCurrentUser()!.uid;

// align message to the right if sender is the current user, otherwise left
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

     return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
        isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
      ChatBubble(message: data['message'],
          isCurrentUser: isCurrentUser,
        messageId: doc.id,
        userId: data['senderID'],
      ),

// ChatBubble

      ]),
    );
  }

  Widget buildUserInput() {
    return Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(children: [
          Expanded(
            child: MyTextField(
                hintText: "Type a message",
                controller: messageController,
                obsecureText: false,
              focusNode: myFocusNode,

            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ), // BoxDecoration
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.arrow_upward,
                color: Colors.white, // Icon
              ), // IconButton
            ), // Container
          ),
        ]));
  }
}
