import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';

import '../Config/My-Text_Field.dart';
import '../Config/My_Button.dart';
import '../Controllers/RegisterController.dart'; // Ensure you import the package if you're using it

class RegisterPage extends StatelessWidget {
  final VoidCallback onTap;

  // Get the RegisterController instance
  final RegisterController registerController = Get.put(RegisterController());

  RegisterPage({super.key, required this.onTap});

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
              "Let's create an account for you",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
            const Gap(50),
            MyTextField(
              hintText: "Email",
              controller: registerController.emailController,
              obsecureText: false,
            ),
            const Gap(20),
            MyTextField(
              hintText: "Password",
              controller: registerController.passwordController,
              obsecureText: true,
            ),
            const Gap(20),
            MyTextField(
              hintText: "Confirm Password",
              controller: registerController.confirmPasswordController,
              obsecureText: true,
            ),
            const Gap(50),
            Obx(() {
              // Show a loading spinner if isLoading is true
              return registerController.isLoading.value
                  ? const CircularProgressIndicator()
                  : MyButton(
                text: "Register",
                tap: registerController.register,
              );
            }),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Login Now",
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
