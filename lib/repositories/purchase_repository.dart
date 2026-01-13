import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/purchase_model.dart';

class PurchaseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collection = 'purchases';

  /// ➕ Add Purchase
  Future<void> addPurchase(PurchaseModel purchase) async {
    await _firestore
        .collection(_collection)
        .doc(purchase.id)
        .set(purchase.toMap());
  }

  /// 📄 Get All Purchases
  Stream<List<PurchaseModel>> streamPurchases() {
    return _firestore
        .collection(_collection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => PurchaseModel.fromMap(doc.id, doc.data()))
          .toList();
    });
  }

  /// ❌ Delete Purchase
  Future<void> deletePurchase(String id) async {
    await _firestore.collection(_collection).doc(id).delete();
  }
}
