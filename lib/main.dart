import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop_care_ptv_ltd/repositories/offline_queue_repository.dart';
import 'package:crop_care_ptv_ltd/screens/dashboard/admin/admin_dashboard.dart';
import 'package:crop_care_ptv_ltd/screens/dashboard/employee/employee_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/controllers/ledger_controller.dart';
import 'core/controllers/outstanding_controller.dart';
import 'core/controllers/payment_controller.dart';
import 'core/controllers/retailer_controller.dart';
import 'core/controllers/retailers_summary_controller.dart';
import 'core/controllers/sales_controller.dart';
import 'core/services/auth_service.dart';
import 'core/services/firestore_service.dart';
import 'core/services/ledger_service.dart';
import 'core/services/local_storage_service.dart';
import 'core/services/outstanding_service.dart';
import 'core/services/payment_service.dart';
import 'core/services/retailers_service.dart';
import 'core/services/retailers_summary_service.dart';
import 'core/services/sales_service.dart';
import 'core/services/sync_service.dart';
import 'firebase_options.dart';
import 'screens/login_screen/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  print('🔥 Firebase initialized');

  // ✅ SETUP AUTHENTICATION FIRST
  await setupAuthentication();

  // ✅ Now initialize your services/controllers
  initializeServices();

  runApp(const MyApp());
}

Future<void> setupAuthentication() async {
  try {
    print('🔐 Setting up authentication...');

    // Check if user is already authenticated
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print('👤 No user found, signing in anonymously...');

      // Sign in anonymously
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      user = userCredential.user;

      print('✅ Signed in anonymously: ${user?.uid}');
    } else {
      print('✅ User already authenticated: ${user.uid}');
      print('   Is anonymous: ${user.isAnonymous}');
    }

    // Create/update user document in Firestore
    if (user != null) {
      await ensureUserDocument(user);
    }
  } catch (e) {
    print('❌ Authentication setup failed: $e');
    print('   Error type: ${e.runtimeType}');

    // Try one more time with a delay
    await Future.delayed(Duration(seconds: 2));
    try {
      if (FirebaseAuth.instance.currentUser == null) {
        await FirebaseAuth.instance.signInAnonymously();
        print('✅ Retry successful');
      }
    } catch (retryError) {
      print('❌ Retry also failed: $retryError');
    }
  }
}

Future<void> ensureUserDocument(User user) async {
  try {
    final userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid);
    final doc = await userRef.get();

    if (!doc.exists) {
      // Create new user document
      await userRef.set({
        'uid': user.uid,
        'role': 'user', // Default role
        'email': user.email ?? '',
        'isAnonymous': user.isAnonymous,
        'createdAt': FieldValue.serverTimestamp(),
        'lastLogin': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      print('📝 Created user document with role: user');
    } else {
      // Update last login
      await userRef.update({'lastLogin': FieldValue.serverTimestamp()});
      print('📝 Updated user last login');

      // Check user role
      final data = doc.data();
      if (data != null && data['role'] != null) {
        print('👤 User role: ${data['role']}');
      }
    }
  } catch (e) {
    print('⚠️ Could not create/update user document: $e');
  }
}

void initializeServices() {
  print('⚙️ Initializing services...');

  // Firestore service first
  Get.put(FirestoreService());
  Get.put(OfflineQueueRepository());
  Get.put(SyncService());

  // Business services
  Get.put(SalesService());
  Get.put(SalesController());

  Get.put(RetailerService());
  Get.put(RetailerController());

  Get.put(PaymentService());
  Get.put(PaymentController());

  Get.put(OutstandingService());
  Get.put(OutstandingController());

  Get.put(RetailersSummaryService());
  Get.put(RetailersSummaryController());

  Get.put(LedgerService());
  Get.put(LedgerController());
  Get.put(LocalStorageService());
  Get.put(AuthService());
  print('✅ All services initialized');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/admin-dashboard', page: () => const AdminDashboard()),
        GetPage(
          name: '/employee-dashboard',
          page: () => const EmployeeDashboard(),
        ),
      ],
    );
  }
}
