import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../../models/user_model.dart';
import '../../repositories/auth_repository.dart';
import 'local_storage_service.dart';

class AuthService extends GetxService {
  final AuthRepository _repo = AuthRepository();
  final LocalStorageService _storage = Get.find();

  final Rx<UserModel?> _currentUser = Rx<UserModel?>(null);
  final RxBool _isAuthenticated = false.obs;
  final RxBool _isOnline = true.obs;
  final RxString _authError = ''.obs;

  // ================= GETTERS =================
  UserModel? get currentUser => _currentUser.value;
  bool get isAuthenticated => _isAuthenticated.value;
  bool get isOnline => _isOnline.value;
  String get authError => _authError.value;

  bool get isAdmin => _currentUser.value?.isAdmin ?? false;
  bool get isEmployee => _currentUser.value?.isEmployee ?? false;

  // ================= STREAM =================
  Stream<List<UserModel>> get pendingEmployeesStream =>
      _repo.pendingEmployeesStream();

  // ================= INIT =================
  Future<AuthService> initialize() async {
    final connectivity = Connectivity();
    final result = await connectivity.checkConnectivity();
    _isOnline.value = !result.contains(ConnectivityResult.none);

    connectivity.onConnectivityChanged.listen((results) {
      _isOnline.value =
          results.isNotEmpty && results.first != ConnectivityResult.none;
    });

    if (_storage.isUserLoggedIn()) {
      _currentUser.value = UserModel(
        id: _storage.getUserId()!,
        name: _storage.getUserName()!,
        email: _storage.getUserEmail()!,
        role: _storage.getUserRole()!,
      );
      _isAuthenticated.value = true;
    }

    return this;
  }

  // ================= LOGIN =================
  Future<bool> login(String email, String password) async {
    try {
      _authError.value = '';
      final user = await _repo.login(email, password);

      if (user == null) {
        _authError.value = 'Invalid email or password';
        return false;
      }

      if (user.isEmployee && !user.isApproved) {
        _authError.value = 'Waiting for admin approval';
        return false;
      }

      _currentUser.value = user;
      _isAuthenticated.value = true;

      await _storage.saveUserData(
        userId: user.id,
        name: user.name,
        email: user.email,
        role: user.role,
      );

      return true;
    } catch (e) {
      _authError.value = e.toString();
      return false;
    }
  }

  // ================= REGISTER =================
  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      _authError.value = '';
      final user = await _repo.register(
        name: name,
        email: email,
        password: password,
        role: role,
      );

      if (user == null) return false;

      _currentUser.value = user;
      _isAuthenticated.value = true;
      return true;
    } catch (e) {
      _authError.value = e.toString();
      return false;
    }
  }

  // ================= APPROVE =================
  Future<void> approveEmployee(String uid) async {
    await _repo.approveEmployee(uid);
  }

  // ================= LOGOUT =================
  Future<void> logout() async {
    await _repo.logout();
    await _storage.clearUserData();
    _currentUser.value = null;
    _isAuthenticated.value = false;
  }
}
