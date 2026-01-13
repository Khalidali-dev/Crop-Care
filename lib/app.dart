// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
//
// import 'core/services/auth_service.dart';
// import 'core/services/sync_service.dart';
// import 'providers/auth_provider.dart';
// import 'screens/login_screen/login_screen.dart';
// import 'screens/dashboard/admin/admin_dashboard.dart';
// import 'screens/dashboard/employee/employee_dashboard.dart';
//
// class App extends StatefulWidget {
//   const App({super.key});
//
//   @override
//   State<App> createState() => _AppState();
// }
//
// class _AppState extends State<App> {
//   final AuthService _authService = Get.find();
//   final SyncService _syncService = Get.find();
//
//   bool _loading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _init();
//   }
//
//   Future<void> _init() async {
//     await _syncService.initialize();
//     await _authService.initialize();
//     setState(() => _loading = false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => AuthProvider(),
//       child: Consumer<AuthProvider>(
//         builder: (_, provider, __) {
//           if (_loading) {
//             return const Scaffold(
//               body: Center(child: CircularProgressIndicator()),
//             );
//           }
//
//           if (!_authService.isAuthenticated) {
//             return const LoginScreen();
//           }
//
//           if (_authService.isAdmin) {
//             return const AdminDashboard();
//           }
//
//           if (_authService.isEmployee) {
//             return const EmployeeDashboard();
//           }
//
//           return const LoginScreen();
//         },
//       ),
//     );
//   }
// }
