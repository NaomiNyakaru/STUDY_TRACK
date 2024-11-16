import 'package:flutter/material.dart';

Widget myTextField({
  required TextEditingController controller,
  String hint = "",
  IconData icon = Icons.abc,
  bool isPassword = false,
  Color? iconColor,
  double borderRadius = 90,
  void Function(String)? onChanged,

  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      onChanged: onChanged, 
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(width: 2.0),
        ),
        prefixIcon: Icon(icon, color: iconColor),
        suffixIcon: isPassword 
            ? Icon(Icons.visibility, color: iconColor)
            : null,
      ),
    );
  }