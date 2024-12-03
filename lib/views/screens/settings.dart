import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
     
    final RxBool isNotificationsEnabled = true.obs;
    final RxString selectedLanguage = 'English'.obs;

    final List<String> languages = ['English', 'Spanish', 'French', 'German'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Settings"),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            
            _buildToggleRow(
              'Enable Notifications',
              Obx(() {
                return Switch(
                  value: isNotificationsEnabled.value,
                  onChanged: (value) {
                    isNotificationsEnabled.value = value;
                  },
                );
              }),
            ),
            const Divider(),
           
            const Text(
              'Language',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Obx(() {
              return DropdownButton<String>(
                value: selectedLanguage.value,
                items: languages.map((String language) {
                  return DropdownMenuItem<String>(
                    value: language,
                    child: Text(language),
                  );
                }).toList(),
                onChanged: (newValue) {
                  selectedLanguage.value = newValue!;
                },
              );
            }),
            const Divider(),
            
            const Text(
              'Account',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Update Account Info'),

              onTap: () {
                Get.toNamed("/profile");
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () {
                Get.toNamed('/');
              },
            ),
            const Divider(),
            
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Privacy Policy'),
              onTap: () {
             
              },
            ),
            ListTile(
              leading: const Icon(Icons.security),
              title: const Text('Security Settings'),
              onTap: () {
                
              },
            ),
            const Divider(),
           
            ListTile(
              leading: const Icon(Icons.restore),
              title: const Text('Reset to Default Settings'),
              onTap: () {
              
              },
            ),
            const Divider(),
           
            const Text(
              'About',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('App Version: 1.0.0'),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Developed by Study Track Team'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleRow(String title, Widget toggle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        toggle,
      ],
    );
  }
}
