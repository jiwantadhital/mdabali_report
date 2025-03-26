import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  final String title;
  final String message;
  final SnackPosition snackPosition;
  // Constructor to pass content (message),
  CustomSnackbar({
    required this.title,
    required this.message,
    required this.snackPosition,
  });

  // Function to show the Snackbar
  void show() {
    Get.snackbar(title, message,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(12),
        isDismissible: true,
        snackPosition: snackPosition,
        backgroundColor: const Color.fromARGB(115, 103, 101, 101),
        colorText: Colors.black);
  }
}
