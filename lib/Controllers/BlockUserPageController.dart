import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../FirebaseServices/Auth_Service.dart';
import '../FirebaseServices/Chat_Service.dart';

class BlockUserPageController extends GetxController{


  final chatService = ChatService();
  final authService = AuthServices();

  void showUnblockBox(BuildContext context, String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: const Text("Unblock User"),
          content: const Text("Are you sure you want to unblock this user?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ), // TextButton

// unblock button
            TextButton(
              onPressed: () {
                chatService.unblockUser(userId);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("User unblocked!")));
              },
              child: const Text("Unblock"),
            ),
          ]),
    );
  }



}