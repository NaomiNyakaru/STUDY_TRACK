import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_track/controllers/dashboardcontroller.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
   
    final Dashboardcontroller controller = Get.put(Dashboardcontroller());

    return Scaffold(
      body: Obx(
        () => controller.myScreens[controller.currentIndex.value],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: controller.myMenus,
          selectedItemColor: Colors.blueAccent,
          selectedLabelStyle: const TextStyle(
            color: Color.fromARGB(255, 188, 145, 196),
          ),
          unselectedItemColor: Colors.black45,
          showUnselectedLabels: true,
          onTap: (index) => controller.changeTab(index),
          currentIndex: controller.currentIndex.value,
          unselectedLabelStyle: const TextStyle(color: Colors.green),
        ),
      ),
    );
  }
}