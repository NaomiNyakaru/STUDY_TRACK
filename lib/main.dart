import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_track/configs/routes.dart';  // Import your routes file
import 'package:study_track/views/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return GetMaterialApp(
      initialRoute: '/',
      getPages: routes,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
         
         body: Login(),
        ),
      );

  } 
 
}
