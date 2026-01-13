// ============================================
// AUTH PROVIDER - FOR UI STATE MANAGEMENT
// ============================================

import 'package:flutter/material.dart';
import '../core/services/auth_service.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String? _error;
  String? _successMessage;

  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get successMessage => _successMessage;

  bool get isAuthenticated => _authService.isAuthenticated;
  bool get isAdmin => _authService.isAdmin;
  bool get isEmployee => _authService.isEmployee;
  bool get isOnline => _authService.isOnline;
  String? get authError => _authService.authError;

  // ============================================
  // 🔥 ADDED: PENDING EMPLOYEES STREAM
  // ============================================
  Stream<List<UserModel>> get pendingEmployeesStream {
    return _authService.pendingEmployeesStream;
  }

  // ============================================
  // 🔥 ADDED: APPROVE EMPLOYEE
  // ============================================
  Future<void> approveEmployee(String userId) async {
    await _authService.approveEmployee(userId);
    notifyListeners();
  }

  // ============================================
  // LOGIN
  // ============================================
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    _successMessage = null;
    notifyListeners();

    final success = await _authService.login(email, password);

    if (!success) {
      _error = _authService.authError ?? 'Login failed';
    } else {
      _successMessage = 'Login successful!';
    }

    _isLoading = false;
    notifyListeners();
    return success;
  }

  // ============================================
  // REGISTER
  // ============================================
  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String role,
  }) async {
    _isLoading = true;
    _error = null;
    _successMessage = null;
    notifyListeners();

    final success = await _authService.register(
      name: name,
      email: email,
      password: password,
      role: role,
    );

    if (success) {
      _successMessage = 'Registration successful! Waiting for admin approval.';
    } else {
      _error = _authService.authError ?? 'Registration failed';
    }

    _isLoading = false;
    notifyListeners();
    return success;
  }

  Future<void> logout() async {
    await _authService.logout();
    notifyListeners();
  }

  void clearMessages() {
    _error = null;
    _successMessage = null;
    notifyListeners();
  }
}
