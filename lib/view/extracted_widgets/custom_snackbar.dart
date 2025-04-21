import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  final String title;
  final String message;
  final SnackPosition snackPosition;
  final Color backgroundColor;
  final Color textColor;
  // Constructor to pass content (message),
  CustomSnackbar({
    required this.title,
    required this.message,
    required this.snackPosition,
    required this.backgroundColor,
    required this.textColor,
  });

  // Function to show the Snackbar
  void show() {
    Get.snackbar(title, message,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(12),
        isDismissible: true,
        snackPosition: snackPosition,
        backgroundColor: backgroundColor,
        colorText: textColor);
  }
}
