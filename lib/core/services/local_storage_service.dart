// ============================================
// LOCAL STORAGE SERVICE - NO DEPENDENCIES
// ============================================
// Manages SharedPreferences for simple key-value storage

import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class LocalStorageService extends GetxService {
  late SharedPreferences _prefs;

  // ============================================
  // INITIALIZATION
  // ============================================
  Future<LocalStorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  // ============================================
  // AUTH-RELATED METHODS
  // ============================================

  /// Save authentication token
  Future<void> saveAuthToken(String token) async {
    await _prefs.setString('auth_token', token);
  }

  /// Get authentication token
  String? getAuthToken() {
    return _prefs.getString('auth_token');
  }

  /// Save user data
  Future<void> saveUserData({
    required String userId,
    required String name,
    required String email,
    required String role,
  }) async {
    await _prefs.setString('user_id', userId);
    await _prefs.setString('user_name', name);
    await _prefs.setString('user_email', email);
    await _prefs.setString('user_role', role);
    await _prefs.setBool('is_logged_in', true);
  }

  /// Get user ID
  String? getUserId() {
    return _prefs.getString('user_id');
  }

  /// Get user name
  String? getUserName() {
    return _prefs.getString('user_name');
  }

  /// Get user email
  String? getUserEmail() {
    return _prefs.getString('user_email');
  }

  /// Get user role
  String? getUserRole() {
    return _prefs.getString('user_role');
  }

  /// Check if user is logged in
  bool isUserLoggedIn() {
    return _prefs.getBool('is_logged_in') ?? false;
  }

  /// Clear all user data (logout)
  Future<void> clearUserData() async {
    await _prefs.remove('auth_token');
    await _prefs.remove('user_id');
    await _prefs.remove('user_name');
    await _prefs.remove('user_email');
    await _prefs.remove('user_role');
    await _prefs.setBool('is_logged_in', false);
  }

  // ============================================
  // SYNC-RELATED METHODS
  // ============================================

  /// Save last sync time
  Future<void> saveLastSyncTime(DateTime time) async {
    await _prefs.setString('last_sync_time', time.toIso8601String());
  }

  /// Get last sync time
  DateTime? getLastSyncTime() {
    final timeString = _prefs.getString('last_sync_time');
    return timeString != null ? DateTime.parse(timeString) : null;
  }

  /// Save offline mode setting
  Future<void> setOfflineMode(bool enabled) async {
    await _prefs.setBool('offline_mode', enabled);
  }

  /// Get offline mode setting
  bool getOfflineMode() {
    return _prefs.getBool('offline_mode') ?? false;
  }

  // ============================================
  // APP SETTINGS
  // ============================================

  /// Save theme mode
  Future<void> setThemeMode(bool isDarkMode) async {
    await _prefs.setBool('is_dark_mode', isDarkMode);
  }

  /// Get theme mode
  bool? getThemeMode() {
    return _prefs.getBool('is_dark_mode');
  }

  /// Save language
  Future<void> setLanguage(String languageCode) async {
    await _prefs.setString('language_code', languageCode);
  }

  /// Get language
  String? getLanguage() {
    return _prefs.getString('language_code');
  }

  /// Save notification setting
  Future<void> setNotificationsEnabled(bool enabled) async {
    await _prefs.setBool('notifications_enabled', enabled);
  }

  /// Get notification setting
  bool getNotificationsEnabled() {
    return _prefs.getBool('notifications_enabled') ?? true;
  }

  // ============================================
  // GENERAL METHODS
  // ============================================

  /// Save string
  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  /// Get string
  String? getString(String key) {
    return _prefs.getString(key);
  }

  /// Save boolean
  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  /// Get boolean
  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  /// Save integer
  Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  /// Get integer
  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  /// Save double
  Future<void> setDouble(String key, double value) async {
    await _prefs.setDouble(key, value);
  }

  /// Get double
  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  /// Remove key
  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  /// Clear all data
  Future<bool> clearAll() async {
    return await _prefs.clear();
  }
}