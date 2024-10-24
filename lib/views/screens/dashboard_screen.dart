import 'package:flutter/material.dart';

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
      body: const Center(
        child: Text('Welcome to the dashboard'),
      ),
    );
  }
}