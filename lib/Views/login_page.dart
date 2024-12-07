import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';

import '../Config/My-Text_Field.dart';
import '../Config/My_Button.dart';
import '../Controllers/LoginController.dart'; // Ensure you import the package if you're using it

class LoginPage extends StatelessWidget {
  final VoidCallback onTap;

  // Get the LoginController instance
  final LoginController loginController = Get.put(LoginController());

  LoginPage({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.message,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),
            const Gap(20),
            Text(
              "Welcome back, you have been missed",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
            const Gap(50),
            MyTextField(
              hintText: "Email",
              controller: loginController.emailController,
              obsecureText: false,
            ),
            const Gap(20),
            MyTextField(
              hintText: "Password",
              controller: loginController.passwordController,
              obsecureText: true,
            ),
            const Gap(50),
            Obx(() {
              // Show a loading spinner if isLoading is true
              return loginController.isLoading.value
                  ? const CircularProgressIndicator()
                  : MyButton(
                text: "Login",
                tap: loginController.login,
              );
            }),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a member? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
