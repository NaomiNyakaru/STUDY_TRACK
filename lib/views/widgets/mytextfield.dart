import 'package:flutter/material.dart';

Widget myTextField(
    {required TextEditingController controller, 
    String hint="",
    IconData icon=Icons.abc, 
    bool isPassword = false}) {
  return TextField(
    controller: controller,
    obscureText: isPassword,
    decoration: InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(90)
      ),
      prefixIcon: Icon(icon),
      suffixIcon: isPassword ? Icon(Icons.visibility) : null
    ),
  );
}