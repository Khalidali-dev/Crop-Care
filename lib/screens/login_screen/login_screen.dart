import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLogin = true;
  bool _isLoading = false;

  final AuthService authService = Get.find<AuthService>();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    bool success = false;

    if (_isLogin) {
      success = await authService.login(
        _email.text.trim(),
        _password.text.trim(),
      );
    } else {
      success = await authService.register(
        name: 'Employee',
        email: _email.text.trim(),
        password: _password.text.trim(),
        role: 'employee',
      );
    }

    setState(() => _isLoading = false);

    // ❌ FAILED
    if (!success) {
      Get.snackbar(
        'Error',
        authService.authError,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // ✅ SUCCESS → NAVIGATION
    if (authService.isAdmin) {
      Get.offAllNamed('/admin-dashboard');
    } else {
      Get.offAllNamed('/employee-dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLogin ? 'Login' : 'Register'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // EMAIL
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (v) =>
                v == null || v.isEmpty ? 'Enter email' : null,
              ),

              const SizedBox(height: 12),

              // PASSWORD
              TextFormField(
                controller: _password,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (v) =>
                v == null || v.length < 6 ? 'Min 6 characters' : null,
              ),

              const SizedBox(height: 24),

              // BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  child: _isLoading
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : Text(_isLogin ? 'LOGIN' : 'REGISTER'),
                ),
              ),

              const SizedBox(height: 12),

              // SWITCH LOGIN / REGISTER
              TextButton(
                onPressed: _isLoading
                    ? null
                    : () {
                  setState(() {
                    _isLogin = !_isLogin;
                  });
                },
                child: Text(
                  _isLogin
                      ? 'Create employee account'
                      : 'Back to login',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
