import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelperFunctions {
  static GetSnackBar customAppSnackBar({
    required String message,
    required Color color,
    required IconData icon,
  }) {
    return GetSnackBar(
      message: message,
      backgroundColor: color,
      icon: Icon(icon, color: Colors.white),
      dismissDirection: DismissDirection.horizontal,
      duration: Duration(seconds: 3),
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeIn,
      borderRadius: 20,
      mainButton: TextButton(
        onPressed: () => Get.back(),
        child: Text('OK', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
