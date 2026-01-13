import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/retailers_summary_model.dart';

class RetailersSummaryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collection = 'retailers_summary';

  /// 📄 Stream All Summaries
  Stream<List<RetailersSummaryModel>> streamSummaries() {
    return _firestore
        .collection(_collection)
        .orderBy('retailerName')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) =>
          RetailersSummaryModel.fromMap(doc.id, doc.data()))
          .toList();
    });
  }

  /// 📄 Get Summary by Retailer
  Future<RetailersSummaryModel?> getByRetailer(
      String retailerId) async {
    final query = await _firestore
        .collection(_collection)
        .where('retailerId', isEqualTo: retailerId)
        .limit(1)
        .get();

    if (query.docs.isEmpty) return null;

    final doc = query.docs.first;
    return RetailersSummaryModel.fromMap(doc.id, doc.data());
  }

  /// 💾 Save / Update Summary
  Future<void> saveSummary(RetailersSummaryModel model) async {
    await _firestore
        .collection(_collection)
        .doc(model.id)
        .set(model.toMap(), SetOptions(merge: true));
  }
}
