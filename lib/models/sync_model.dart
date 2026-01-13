// ============================================
// SYNC MODEL - NO DEPENDENCIES
// ============================================
// Tracks data that needs to be synced to Firebase

import 'package:hive/hive.dart';


@HiveType(typeId: 2)
class SyncModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String collection; // 'users', 'purchases', etc.

  @HiveField(2)
  final SyncAction action; // create, update, delete

  @HiveField(3)
  final Map<String, dynamic> data;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  bool synced;

  @HiveField(6)
  DateTime? syncedAt;

  @HiveField(7)
  int retryCount;

  SyncModel({
    required this.id,
    required this.collection,
    required this.action,
    required this.data,
    required this.createdAt,
    this.synced = false,
    this.syncedAt,
    this.retryCount = 0,
  });

  // ============================================
  // CONVERT TO MAP
  // ============================================
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'collection': collection,
      'action': action.name,
      'data': data,
      'createdAt': createdAt.toIso8601String(),
      'synced': synced,
      'syncedAt': syncedAt?.toIso8601String(),
      'retryCount': retryCount,
    };
  }

  // ============================================
  // FACTORY FROM MAP
  // ============================================
  factory SyncModel.fromMap(Map<String, dynamic> map) {
    return SyncModel(
      id: map['id'],
      collection: map['collection'],
      action: SyncAction.values.firstWhere(
            (e) => e.name == map['action'],
        orElse: () => SyncAction.create,
      ),
      data: Map<String, dynamic>.from(map['data']),
      createdAt: DateTime.parse(map['createdAt']),
      synced: map['synced'],
      syncedAt: map['syncedAt'] != null
          ? DateTime.parse(map['syncedAt'])
          : null,
      retryCount: map['retryCount'] ?? 0,
    );
  }

  // ============================================
  // MARK AS SYNCED
  // ============================================
  SyncModel markAsSynced() {
    return SyncModel(
      id: id,
      collection: collection,
      action: action,
      data: data,
      createdAt: createdAt,
      synced: true,
      syncedAt: DateTime.now(),
      retryCount: retryCount,
    );
  }

  // ============================================
  // INCREMENT RETRY COUNT
  // ============================================
  SyncModel incrementRetry() {
    return SyncModel(
      id: id,
      collection: collection,
      action: action,
      data: data,
      createdAt: createdAt,
      synced: synced,
      syncedAt: syncedAt,
      retryCount: retryCount + 1,
    );
  }

  // ============================================
  // SHOULD RETRY?
  // ============================================
  bool get shouldRetry => retryCount < 3;
}

// ============================================
// SYNC ACTION ENUM
// ============================================
enum SyncAction {
  create,
  update,
  delete,
}

// ============================================
// SYNC STATUS ENUM
// ============================================
enum SyncStatus {
  pending,
  inProgress,
  completed,
  failed,
}