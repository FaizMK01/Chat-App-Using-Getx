import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../FirebaseServices/Auth_Service.dart';

class RegisterController extends GetxController {
  // Controllers for text fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Instance of AuthServices
  final AuthServices authServices = AuthServices();

  // Loading state
  var isLoading = false.obs;

  // Registration function
  Future<void> register() async {
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        "Failed",
        "Passwords don't match",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    isLoading.value = true; // Start loading
    try {
      await authServices.signUp(
        emailController.text,
        passwordController.text,
      );
      Get.snackbar(
        "Success",
        "Account created successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Registration Failed",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
