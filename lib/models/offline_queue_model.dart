class OfflineQueueModel {
  final String id;
  final String type;       // create | update | delete
  final String collection;
  final Map<String, dynamic> data;
  final DateTime createdAt;
  final bool synced;

  OfflineQueueModel({
    required this.id,
    required this.type,
    required this.collection,
    required this.data,
    required this.createdAt,
    required this.synced,
  });

  factory OfflineQueueModel.fromMap(
      String id, Map<String, dynamic> map) {
    return OfflineQueueModel(
      id: id,
      type: map['type'],
      collection: map['collection'],
      data: Map<String, dynamic>.from(map['data']),
      createdAt: DateTime.parse(map['createdAt']),
      synced: map['synced'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'collection': collection,
      'data': data,
      'createdAt': createdAt.toIso8601String(),
      'synced': synced,
    };
  }
}
