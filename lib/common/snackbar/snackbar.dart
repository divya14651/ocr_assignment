import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowSnackBar {

  static void show(String message) {
    Get.dialog(
      AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  static void goHome(String message) {
    Get.offAllNamed("/home");
    Get.snackbar("Error", message);
  }
}