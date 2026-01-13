import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/offline_queue_model.dart';

class OfflineQueueRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collection = 'offline_queue';

  /// ➕ Add to Queue
  Future<void> add(OfflineQueueModel model) async {
    await _firestore
        .collection(_collection)
        .doc(model.id)
        .set(model.toMap());
  }

  /// 📄 Get Pending Items
  Future<List<OfflineQueueModel>> getPending() async {
    final query = await _firestore
        .collection(_collection)
        .where('synced', isEqualTo: false)
        .get();

    return query.docs
        .map((doc) =>
        OfflineQueueModel.fromMap(doc.id, doc.data()))
        .toList();
  }

  /// ✅ Mark Synced
  Future<void> markAsSynced(String id) async {
    await _firestore
        .collection(_collection)
        .doc(id)
        .update({'synced': true});
  }
}
