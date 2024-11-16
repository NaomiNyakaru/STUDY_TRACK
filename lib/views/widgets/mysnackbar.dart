import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';  
import 'package:study_track/configs/colors.dart';
import 'package:get/get.dart';

mysnackbar({
  required String title,
  required String message,
  required String type, 
}) {
  IconData getIcon() {
    switch (type.toLowerCase()) {
      case 'success':
        return Icons.check_circle;
      case 'error':
        return Icons.error;
      case 'info':
        return Icons.info;
      case 'warning':
        return Icons.warning;
      default:
        return Icons.info;
    }
  }

  Color getColor() {
    switch (type.toLowerCase()) {
      case 'success':
        return Colors.green;
      case 'error':
        return Colors.red;
      case 'warning':
        return Colors.orange;
      case 'info':
        return mainColor;
      default:
        return mainColor;
    }
  }

  return Get.snackbar(
    title,
    message,
    icon: Icon(
      getIcon(),
      color: appWhite,
    ),
    colorText: appWhite,
    backgroundColor: getColor(),
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.all(10),
    duration: const Duration(seconds: 3),
    borderRadius: 8,
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
  );
}