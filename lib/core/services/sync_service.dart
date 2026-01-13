import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../repositories/offline_queue_repository.dart';


class SyncService extends GetxService {
  final OfflineQueueRepository _queueRepo =
  OfflineQueueRepository();

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  /// 🔄 CALL THIS ON APP START
  Future<void> initialize() async {
    final pending = await _queueRepo.getPending();

    for (final item in pending) {
      try {
        final ref =
        _firestore.collection(item.collection).doc();

        if (item.type == 'create') {
          await ref.set(item.data);
        } else if (item.type == 'update') {
          await ref.update(item.data);
        } else if (item.type == 'delete') {
          await ref.delete();
        }

        await _queueRepo.markAsSynced(item.id);
      } catch (e) {
        // stop syncing if error
        break;
      }
    }
  }
}
