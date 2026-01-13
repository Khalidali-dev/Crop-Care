import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Panel')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Admin
                Get.toNamed('/pin', arguments: {'role': 'admin'});
              },
              child: const Text('Admin Panel'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Employee
                Get.toNamed('/pin', arguments: {'role': 'employee'});
              },
              child: const Text('Employee Panel'),
            ),
          ],
        ),
      ),
    );
  }
}
