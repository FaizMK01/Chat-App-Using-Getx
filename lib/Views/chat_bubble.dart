import 'package:chat_app/FirebaseServices/Chat_Service.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final String messageId;
  final String userId;



  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
    required this.messageId,
    required this.userId,
  });

  void showOptions(BuildContext context, String messageId, String userId) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
            child: Wrap(children: [
              ListTile(
                leading: const Icon(Icons.flag),
                title: const Text('Report'),
                onTap: () {
                  Navigator.pop(context);
                  reportMessage(context, messageId, userId);
                },
              ),
              ListTile(
                leading: const Icon(Icons.block),
                title: const Text('Block'),
                onTap: () {

                  Navigator.pop(context);
                  blockUser(context, userId);
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel),
                title: const Text('Cancel'),
                onTap: () => Navigator.pop(context),
              ),

            ]), // Wrap
          );
        });
  } // SafeArea
  void reportMessage(BuildContext context, String messageId, String userId) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: const Text("Report Message"),
            content: const Text("Are you sure you want to report this message?"),
            actions: [
// cancel button
            TextButton(
            onPressed: () => Navigator.pop(context),
    child: const Text("Cancel"),
    ), // TextButton

// report button
    TextButton(
    onPressed: (){
    ChatService().reportUser(messageId, userId);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Message Reported")));
    },

    child: const Text("Report"),
    ), // TextButton
    ]

    ), // AlertDialog
    );}
  void blockUser(BuildContext context,String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: const Text("Block User"),
          content: const Text("Are you sure you want to block this user?"),
          actions: [
// cancel button
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ), // TextButton

// report button
            TextButton(
              onPressed: (){
                ChatService().blockUser(userId);
                Navigator.pop(context);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("User Blocked")));
              },

              child: const Text("Block"),
            ), // TextButton
          ]

      ), // AlertDialog
    );}


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        if (!isCurrentUser) {
          showOptions(context, messageId, userId);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: isCurrentUser ? Colors.green : Colors.grey.shade500,
          borderRadius: BorderRadius.circular(12),
        ), // BoxDecoration
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 25),
        child: Text(message, style: TextStyle(color: Colors.white) // Text
            ),
      ),
    );
  }
}
