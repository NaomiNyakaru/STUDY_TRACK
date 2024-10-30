import 'package:flutter/material.dart';

List<BottomNavigationBarItem> myMenus = [
  BottomNavigationBarItem(icon: Icon(Icons.home), label:"Home"),
  BottomNavigationBarItem(icon: Icon(Icons.list), label:"Assignments"),
  BottomNavigationBarItem(icon: Icon(Icons.settings), label:"Settings"),
];

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: false,
      ),
      bottomNavigationBar: BottomNavigationBar(items: myMenus),
      body: const Center(
        child: Text('Welcome to the dashboard'),
      ),
    );
  }
}