import 'package:chat_app/Config/my_drawer.dart';
import 'package:chat_app/Controllers/BlockUserPageController.dart';
import 'package:chat_app/FirebaseServices/Auth_Service.dart';
import 'package:chat_app/FirebaseServices/Chat_Service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../Config/user_tile.dart';

class BlockUserPage extends StatelessWidget {
  BlockUserPage({super.key});

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

  @override
  Widget build(BuildContext context) {
    BlockUserPageController blockUserPageController = Get.put(BlockUserPageController());
    final userId= authService.getCurrentUser()!.uid;
    return Scaffold(
      appBar: AppBar(
        title: const Text("BLOCKED USER"),
      ),
      body: StreamBuilder<List<Map<String,dynamic>>>(
          stream: chatService.getBlockedUsersStream(userId),
          builder: (context,snapshot){
            if(snapshot.hasError){
              return Center(
                child: Text("Error"),
              );
            }
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final blockedUsers = snapshot.data ?? [] ;

            if (blockedUsers.isEmpty) {
              return const Center(
                child: Text("No blocked users"),
              );
            }

            return ListView.builder(
              itemCount: blockedUsers.length,
                itemBuilder: (context, index){
                  final user = blockedUsers [index] ;
                  return UserTile(
                    text: user["email"],
                    tap: () => blockUserPageController.showUnblockBox(context,user['id']),
                    // tap: () => showUnblockBox(context,user['id']),
                  );
                }


            ); // ListView.builder
          }




          ),
    );
  }
}
