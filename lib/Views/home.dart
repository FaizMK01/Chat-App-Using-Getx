import 'package:chat_app/Controllers/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Config/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("CHAT USERS"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      drawer: MyDrawer(),
      body: homeController.buildUserList(),
      // body: buildUserList(),
    );
  }
}
