import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/LoginController.dart';

class AuthServices{


  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;


  User? getCurrentUser() => auth.currentUser;

  //signIn function
  Future<UserCredential?> signIn(String email, String password) async {
    try {
      UserCredential credential =
      await auth.signInWithEmailAndPassword(email: email, password: password);

      //save user info
      firestore.collection("Users").doc(credential.user!.uid).
      set({

        "id":credential.user!.uid,
        "email":email

      });
      return credential;


    } on FirebaseAuthException catch (e) {
      // Show a SnackBar using GetX
      Get.snackbar(
        "Login Failed", // Title
        e.message ?? "An error occurred", // Message
        snackPosition: SnackPosition.BOTTOM, // Position of the snackbar
        backgroundColor: Colors.red, // Background color
        colorText: Colors.white, // Text color
        duration: const Duration(seconds: 3), // Duration the snackbar is visible
      );
    }
    return null;
  }
  //signUp function
  Future<UserCredential?> signUp(String email, String password) async {
    try {
      //create user

      UserCredential credential =
      await auth.createUserWithEmailAndPassword(email: email, password: password);

      //save user info
      firestore.collection("Users").doc(credential.user!.uid).
      set({

        "id":credential.user!.uid,
        "email":email

      });
      return credential;
    } on FirebaseAuthException catch (e) {
      // Show a SnackBar using GetX
      Get.snackbar(
        "Signup Failed", // Title
        e.message ?? "An error occurred", // Message
        snackPosition: SnackPosition.BOTTOM, // Position of the snackbar
        backgroundColor: Colors.red, // Background color
        colorText: Colors.white, // Text color
        duration: const Duration(seconds: 3), // Duration the snackbar is visible
      );
    }
    return null;
  }

  void logout() async {
    try {
      await auth.signOut();
      Get.snackbar(
        "User",
       "Logout Successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blueGrey,
        colorText: Colors.white,
      );

      // Clear login fields
      Get.find<LoginController>().clearFields();

      // Optionally reset GetX state and controllers
      Get.reset(); // This will remove all controller instances and their states


    } catch (e) {
      Get.snackbar(
        "Logout Failed",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }


}