import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_track/controllers/registercontroller.dart';
import 'package:study_track/views/widgets/mytextfield.dart';
import 'package:study_track/views/widgets/mysnackbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatelessWidget {
  final TextEditingController fnameInput = TextEditingController();
  final TextEditingController snameInput = TextEditingController();
  final TextEditingController phonenumberInput = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController passwordInput = TextEditingController();
  final Registercontroller registercontroller = Get.put(Registercontroller());
  
  
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final phoneRegex = RegExp(r'^\+?[\d\s-]{10,13}$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () => Get.back(),
                    ),
                    const Expanded(
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 40), 
                  ],
                ),
              ),

              
              Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome to StudyTrack! 👋',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Please fill in your information to get started with your learning journey.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

             
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    
                    
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          myTextField(
                            controller: fnameInput,
                            icon: Icons.person_outline,
                            hint: 'First Name',
                          ),
                          const SizedBox(height: 16),
                          myTextField(
                            controller: snameInput,
                            icon: Icons.person_outline,
                            hint: 'Last Name',
                          ),
                          const SizedBox(height: 16),
                          myTextField(
                            controller: phonenumberInput,
                            icon: Icons.phone_outlined,
                            hint: 'Phone Number',
                          ),
                          const SizedBox(height: 16),
                          myTextField(
                            controller: email,
                            icon: Icons.email_outlined,
                            hint: 'Email Address',
                          ),
                          const SizedBox(height: 16),
                          myTextField(
                            controller: passwordInput,
                            icon: Icons.password_outlined,
                            hint: 'password',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                   
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () async{
                          
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
                         
                          if (passwordInput.text.isEmpty) {
                                mysnackbar(
                                  title: "Error",
                                  message: "Password must be provided",
                                  type: "error",
                                );
                                return;
                              }

                          if (passwordInput.text.length < 6) {  
                            mysnackbar(
                              title: "Error",
                              message: "Password must be at least 6 characters",
                              type: "error",
                            );
                            return;
                          }


                          registercontroller.fname.value = fnameInput.text;
                          registercontroller.sname.value = snameInput.text;
                          registercontroller.phonenumber.value = phonenumberInput.text;
                          registercontroller.email.value = email.text;
                          registercontroller.password.value=passwordInput.text;
                          Uri uri = Uri.http('192.168.39.125', '/study_track/register2.php', {
                          'firstname': fnameInput.text,
                          'lastname': snameInput.text,
                          'phone': phonenumberInput.text,
                          'email': email.text,
                          'password': passwordInput.text,
                        });

                        final response = await http.get(uri);


                        if (response.statusCode == 200) {
                          var serverResponse = json.decode(response.body);
                          int registerStatus = serverResponse['success'];
                          if (registerStatus == 1) {
                              mysnackbar(
                              title: "Success",
                              message: "Registration successful!",
                              type: "success",
                            );           
                            Get.toNamed('/');
                          } else {
                            mysnackbar(
                              title: "Login Failed",
                              message: "Failed to create account",
                              type: "error",
                            );
                          }
                        } else {
                          mysnackbar(
                            title: "Error",
                            message: "Server error occurred. Please try again.",
                            type: "error",
                          );
                        }
                        
                      },
                        child: const Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    // Login Link
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 15,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.toNamed('/login'),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.lightBlueAccent,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Terms and Privacy
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Text(
                        'By creating an account, you agree to our Terms of Service and Privacy Policy',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  }
