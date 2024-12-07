import 'package:chat_app/Views/setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../FirebaseServices/Auth_Service.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  final authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          DrawerHeader(
            child: Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("H O M E"),
            onTap: () {
              // Navigator.pop(context);
              Get.back();
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("S E T T I N G"),
            onTap: () {
              // Get.back();
              // Get.to(() => const Setting());

              Navigator.pop(context);
               Navigator.push(context, MaterialPageRoute(builder: (_)=>const Setting()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("L O G O U T"),
            onTap: () {
              authServices.logout();
            },
          )
        ],
      ),
    );
  }
}
