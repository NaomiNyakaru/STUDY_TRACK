import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_track/views/screens/history.dart';
import 'package:study_track/views/screens/books.dart';
import 'package:study_track/views/screens/homescreen.dart';
import 'package:study_track/views/screens/profile.dart';
import 'package:study_track/views/screens/settings.dart';

class Dashboardcontroller extends GetxController {
 
  final RxInt currentIndex = 0.obs;

 
  final List<Widget> myScreens = [
    Home(),
    Book(),
    History(),
    SettingsScreen(),
    Profile(),
    
    
  ];


  final List<BottomNavigationBarItem> myMenus = [
      const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
      const BottomNavigationBarItem(
      icon: Icon(Icons.book),
      label: 'Books',
    ),
      const BottomNavigationBarItem(
      icon: Icon(Icons.history),
      label: 'History',
    ), const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
      const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
   
     
  ];

  
  void changeTab(int index) {
    currentIndex.value = index;
  }
}