import 'package:firebase_auth/firebase_auth.dart';
import '../../models/user_model.dart';
import '../core/services/firestore_service.dart';


class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestore = FirestoreService();

  static const String _collection = 'users';

  // ================= LOGIN =================
  Future<UserModel?> login(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return getById(credential.user!.uid);
  }

  // ================= REGISTER =================
  Future<UserModel?> register({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = UserModel(
      id: credential.user!.uid,
      name: name,
      email: email,
      role: role,
      isApproved: role == 'admin',
    );

    await _firestore.setData(
      collection: _collection,
      docId: user.id,
      data: user.toMap(),
    );

    return user;
  }

  // ================= GET USER =================
  Future<UserModel?> getById(String uid) async {
    final doc = await _firestore.getById(
      collection: _collection,
      docId: uid,
    );

    if (!doc.exists) return null;
    return UserModel.fromMap(doc.data()!);
  }

  // ================= APPROVE EMPLOYEE =================
  Future<void> approveEmployee(String uid) async {
    await _firestore.setData(
      collection: _collection,
      docId: uid,
      data: {'isApproved': true},
    );
  }

  // ================= PENDING EMPLOYEES =================
  Stream<List<UserModel>> pendingEmployeesStream() {
    return _firestore
        .query(collection: _collection)
        .where('role', isEqualTo: 'employee')
        .where('isApproved', isEqualTo: false)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((d) => UserModel.fromMap(d.data())).toList());
  }

  // ================= LOGOUT =================
  Future<void> logout() async {
    await _auth.signOut();
  }
}
