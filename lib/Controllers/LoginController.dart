import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../FirebaseServices/Auth_Service.dart';

class LoginController extends GetxController {
  // Controllers for text fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Instance of AuthServices
  final AuthServices authServices = AuthServices();

  // Loading state
  var isLoading = false.obs;

  // Login function
  Future<void> login() async {
    isLoading.value = true; // Start loading
    try {
      await authServices.signIn(
        emailController.text,
        passwordController.text,
      );
      Get.snackbar(
        "Login Successful",
        "Welcome back!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Login Failed",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  // Clear text fields
  void clearFields() {
    emailController.clear();
    passwordController.clear();

  }

  @override
  void onClose() {
    // Dispose controllers when the controller is removed from memory
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
