// ============================================
// APP CONSTANTS - NO DEPENDENCIES
// ============================================

class AppConstants {
  // ============================================
  // APP INFO
  // ============================================
  static const String appName = 'Crop Care Pvt Ltd';
  static const String appVersion = '1.0.0';
  static const String companyName = 'Crop Care Private Limited';

  // ============================================
  // FIREBASE COLLECTIONS
  // ============================================
  static const String usersCollection = 'users';
  static const String purchasesCollection = 'purchases';
  static const String salesCollection = 'sales';
  static const String inventoryCollection = 'inventory';

  // ============================================
  // LOCAL STORAGE KEYS
  // ============================================
  static const String authTokenKey = 'auth_token';
  static const String userIdKey = 'user_id';
  static const String userNameKey = 'user_name';
  static const String userEmailKey = 'user_email';
  static const String userRoleKey = 'user_role';
  static const String isLoggedInKey = 'is_logged_in';
  static const String lastSyncTimeKey = 'last_sync_time';

  // ============================================
  // HIVE BOX NAMES (OFFLINE STORAGE)
  // ============================================
  static const String boxUsers = 'users_box';
  static const String boxPurchases = 'purchases_box';
  static const String boxSales = 'sales_box';
  static const String boxInventory = 'inventory_box';
  static const String boxPendingSync = 'pending_sync_box';

  // ============================================
  // USER ROLES (ONLY ADMIN & EMPLOYEE)
  // ============================================
  static const String roleAdmin = 'admin';
  static const String roleEmployee = 'employee';

  // ============================================
  // SYNC SETTINGS
  // ============================================
  static const int syncInterval = 300000; // 5 minutes
  static const int maxRetryAttempts = 3;

  // ============================================
  // APP SETTINGS
  // ============================================
  static const double defaultPadding = 16.0;
  static const double defaultRadius = 12.0;
  static const String currencySymbol = '₹';

  // ============================================
  // ERROR MESSAGES
  // ============================================
  static const String networkError = 'Network error. Please check connection.';
  static const String authError = 'Authentication failed.';
  static const String offlineSaveSuccess = 'Saved locally. Will sync when online.';

  // ============================================
  // SUCCESS MESSAGES
  // ============================================
  static const String loginSuccess = 'Login successful!';
  static const String syncSuccess = 'Data synchronized!';
  static const String saveSuccess = 'Saved successfully!';
}