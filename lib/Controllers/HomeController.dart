import 'package:chat_app/FirebaseServices/Auth_Service.dart';
import 'package:chat_app/FirebaseServices/Chat_Service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Config/user_tile.dart';
import '../Views/chat_page.dart';

class HomeController extends GetxController{

  final chatService = ChatService();
  final authService = AuthServices();

  Widget buildUserList() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: chatService.getUsersStreamExcludingBlocked(),
      builder: (context, snapshot) {

        if (snapshot.hasError) {
          Get.snackbar(
            "Error", // Title
            "An error occurred", // Message
            snackPosition: SnackPosition.BOTTOM, // Position of the snackbar
            backgroundColor: Colors.red, // Background color
            colorText: Colors.white, // Text color
            duration: const Duration(seconds: 3), // Visibility duration
          );
          return Container();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No users found"));
        }

        final users = snapshot.data!;
        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return buildUserListItem(users[index], context);
          },
        );
      },
    );
  }
  Widget buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    // final email = userData['email'] ?? "Unknown";

    if(userData['email'] != authService.getCurrentUser()!.email){
      return UserTile(
        text: userData['email'] ?? "Unknown",
        tap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ChatPage(
              receiverEmail: userData['email'].toString(),
              receiverID: userData['id'].toString(),

            ),
            ),
          );
        },

      );

    }
    else{
      return Container();
    }
  }



}