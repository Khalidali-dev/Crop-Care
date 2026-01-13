import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/retailers_model.dart';

class RetailerRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collection = 'retailers';

  /// ➕ Add Retailer
  Future<void> addRetailer(RetailerModel retailer) async {
    await _firestore
        .collection(_collection)
        .doc(retailer.id)
        .set(retailer.toMap());
  }

  /// 📄 Stream Retailers
  Stream<List<RetailerModel>> streamRetailers() {
    return _firestore
        .collection(_collection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => RetailerModel.fromMap(doc.id, doc.data()))
          .toList();
    });
  }

  /// ❌ Delete Retailer
  Future<void> deleteRetailer(String id) async {
    await _firestore.collection(_collection).doc(id).delete();
  }
}
