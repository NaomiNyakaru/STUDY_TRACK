import 'package:flutter/material.dart';
import 'package:study_track/controllers/logincontroller.dart';
import 'package:study_track/views/screens/register_screen.dart';
import 'package:study_track/views/widgets/mysnackbar.dart';
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
                const SizedBox(height: 10),
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
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Get.toNamed('/forgot-password');
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 0),
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () {
                              if (nameInput.text.isEmpty) {

                                mysnackbar(
                                  title: "Error",
                                  message: "Name must be provided",
                                  type: "error",
                                );
                                return;
                              }
                              
                              if (passwordInput.text.isEmpty) {
                                mysnackbar(
                                  title: "Error",
                                  message: "Password must be provided",
                                  type: "error",
                                );
                                return;
                              }

                              if (passwordInput.text.length < 6) {  // Example minimum length
                                mysnackbar(
                                  title: "Error",
                                  message: "Password must be at least 6 characters",
                                  type: "error",
                                );
                                return;
                              }

                              logincontroller.username.value = nameInput.text;
                              logincontroller.password.value = passwordInput.text;
                              Get.toNamed('/dashboard');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.login, color: Colors.blue),
                                SizedBox(width: 8),
                                Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        // Or divider
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey.shade600,
                                thickness: 0.5,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'OR',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey.shade600,
                                thickness: 0.5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: OutlinedButton.icon(
                            icon: Image.asset(
                              'assets/images/google_icon.png',
                              height: 24.0,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.g_mobiledata);
                              },
                            ),
                            label: const Text(
                              'Sign in with Google',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: const BorderSide(color: Colors.grey),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              // Google Sign In 
                            },
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