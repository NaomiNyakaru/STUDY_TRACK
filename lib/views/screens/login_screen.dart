import 'package:flutter/material.dart';
import 'package:study_track/controllers/logincontroller.dart';
import 'package:study_track/views/screens/register_screen.dart';
import 'package:study_track/views/widgets/mytextfield.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  TextEditingController nameInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();
  
  
  Logincontroller logincontroller = Get.put(Logincontroller());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 50),
                // Logo with padding
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Image.asset(
                    'assets/images/STLogo.png',
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Text('Could not load image');
                    },
                  ),
                ),
                
                // Login form container
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.blue.shade200,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        myTextField(
                          controller: nameInput,
                          icon: Icons.person,
                          hint: "Enter your name"
                        ),
                        const SizedBox(height: 20),
                        myTextField(
                          controller: passwordInput,
                          icon: Icons.key,
                          hint: "Enter your password"
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () {
                              logincontroller.username.value = nameInput.text;
                              logincontroller.password.value = passwordInput.text;
                              Get.toNamed('/dashboard');
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextButton(
                          onPressed: () {
                            logincontroller.username.value = nameInput.text;
                            logincontroller.password.value = passwordInput.text;
                            Get.toNamed('/register');
                          },
                          child: const Text(
                            'Don\'t have an account? Register',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}