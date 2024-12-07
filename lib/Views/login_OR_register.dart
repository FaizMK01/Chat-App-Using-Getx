import 'package:chat_app/Controllers/Login%20OR%20RegisterController.dart';
import 'package:chat_app/Views/login_page.dart';
import 'package:chat_app/Views/register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginOrRegister extends StatelessWidget {
  const LoginOrRegister({super.key});

  @override
  Widget build(BuildContext context) {
    LoginOrRegisterController loginOrRegisterController = Get.put(LoginOrRegisterController());
    return Obx(() {
      // Rebuild UI when showLoginPage changes
      return loginOrRegisterController.showLoginPage.value
          ? LoginPage(onTap: loginOrRegisterController.togglePage)
          : RegisterPage(onTap: loginOrRegisterController.togglePage);
    });
  }
}
