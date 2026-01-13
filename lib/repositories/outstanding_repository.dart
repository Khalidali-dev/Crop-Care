import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/outstanding_model.dart';

class OutstandingRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collection = 'outstanding';

  /// 📄 Stream All Outstanding
  Stream<List<OutstandingModel>> streamOutstanding() {
    return _firestore
        .collection(_collection)
        .orderBy('retailerName')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => OutstandingModel.fromMap(doc.id, doc.data()))
          .toList();
    });
  }

  /// 📄 Get Single Retailer Outstanding
  Future<OutstandingModel?> getByRetailer(String retailerId) async {
    final query = await _firestore
        .collection(_collection)
        .where('retailerId', isEqualTo: retailerId)
        .limit(1)
        .get();

    if (query.docs.isEmpty) return null;

    final doc = query.docs.first;
    return OutstandingModel.fromMap(doc.id, doc.data());
  }

  /// 💾 Save / Update Outstanding
  Future<void> saveOutstanding(OutstandingModel model) async {
    await _firestore
        .collection(_collection)
        .doc(model.id)
        .set(model.toMap(), SetOptions(merge: true));
  }
}
