import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_track/controllers/registercontroller.dart';
import 'package:study_track/views/widgets/mytextfield.dart';
import 'package:study_track/views/widgets/mysnackbar.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController fnameInput = TextEditingController();
  TextEditingController snameInput = TextEditingController();
  TextEditingController phonenumberInput = TextEditingController();
  TextEditingController email = TextEditingController();

  Registercontroller registercontroller = Get.put(Registercontroller());

 
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final phoneRegex = RegExp(r'^\+?[\d\s-]{10,13}$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REGISTER'),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            myTextField(
                controller: fnameInput,
                icon: Icons.person,
                hint: 'Enter first name'),
            SizedBox(height: 10),
            myTextField(
                controller: snameInput,
                icon: Icons.person,
                hint: 'Enter second name'),
            SizedBox(height: 10),
            myTextField(
                controller: phonenumberInput,
                icon: Icons.phone_android,
                hint: 'Enter phone_number'),
            SizedBox(height: 10),
            myTextField(
                controller: email, icon: Icons.email, hint: 'Enter user email'),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  // Validate first name
                  if (fnameInput.text.isEmpty) {
                    mysnackbar(
                      title: "Error",
                      message: "First name must be provided",
                      type: "error",
                    );
                    return;
                  }

                  if (fnameInput.text.length < 2) {
                    mysnackbar(
                      title: "Error",
                      message: "First name must be at least 2 characters",
                      type: "error",
                    );
                    return;
                  }

                  // Validate second name
                  if (snameInput.text.isEmpty) {
                    mysnackbar(
                      title: "Error",
                      message: "Second name must be provided",
                      type: "error",
                    );
                    return;
                  }

                  if (snameInput.text.length < 2) {
                    mysnackbar(
                      title: "Error",
                      message: "Second name must be at least 2 characters",
                      type: "error",
                    );
                    return;
                  }

                  // Validate phone number
                  if (phonenumberInput.text.isEmpty) {
                    mysnackbar(
                      title: "Error",
                      message: "Phone number must be provided",
                      type: "error",
                    );
                    return;
                  }

                  if (!phoneRegex.hasMatch(phonenumberInput.text)) {
                    mysnackbar(
                      title: "Error",
                      message: "Please enter a valid phone number",
                      type: "error",
                    );
                    return;
                  }

                  // Validate email
                  if (email.text.isEmpty) {
                    mysnackbar(
                      title: "Error",
                      message: "Email must be provided",
                      type: "error",
                    );
                    return;
                  }

                  if (!emailRegex.hasMatch(email.text)) {
                    mysnackbar(
                      title: "Error",
                      message: "Please enter a valid email address",
                      type: "error",
                    );
                    return;
                  }

                  registercontroller.fname.value = fnameInput.text;
                  registercontroller.sname.value = snameInput.text;
                  registercontroller.phonenumber.value = phonenumberInput.text;
                  registercontroller.email.value = email.text;

                
                  mysnackbar(
                    title: "Success",
                    message: "Registration successful!",
                    type: "success",
                  );

                 
                  Future.delayed(const Duration(seconds: 2), () {
                    Get.toNamed('/');
                  });
                },
                child: const Text('Register'))
          ],
        ),
      ),
    );
  }
}