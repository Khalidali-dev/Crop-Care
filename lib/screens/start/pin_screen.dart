import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  final TextEditingController _pinController = TextEditingController();

  static const String adminPin = '4862';
  static const String employeePin = '7845';

  String role = '';

  @override
  void initState() {
    super.initState();

    final args = Get.arguments;

    // ✅ HANDLE ALL POSSIBLE CASES
    if (args is Map && args['role'] is String) {
      role = args['role'];
    } else if (args is String) {
      role = args;
    } else {
      Future.microtask(() {
        Get.snackbar(
          'Navigation Error',
          'Invalid access flow',
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.offAllNamed('/start');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (role.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('${role.capitalizeFirst} Access')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter 4-digit password',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _pinController,
              keyboardType: TextInputType.number,
              maxLength: 4,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '****',
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                final enteredPin = _pinController.text;

                if (role == 'admin' && enteredPin == adminPin) {
                  Get.offAllNamed('/admin-dashboard');
                } else if (role == 'employee' && enteredPin == employeePin) {
                  Get.offAllNamed('/employee-dashboard');
                } else {
                  Get.snackbar(
                    'Access Denied',
                    'Incorrect password',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
              child: const Text('VERIFY'),
            ),
          ],
        ),
      ),
    );
  }
}
