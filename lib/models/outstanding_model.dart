import 'package:cloud_firestore/cloud_firestore.dart';

class OutstandingModel {
  final String id;
  final String retailerId;
  final String retailerName;
  final double outstandingBalance;
  final DateTime updatedAt;

  OutstandingModel({
    required this.id,
    required this.retailerId,
    required this.retailerName,
    required this.outstandingBalance,
    required this.updatedAt,
  });

  /// Firestore → Model
  factory OutstandingModel.fromMap(String id, Map<String, dynamic> map) {
    return OutstandingModel(
      id: id,
      retailerId: map['retailerId'],
      retailerName: map['retailerName'],
      outstandingBalance:
      (map['outstandingBalance'] ?? 0).toDouble(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
    );
  }

  /// Model → Firestore
  Map<String, dynamic> toMap() {
    return {
      'retailerId': retailerId,
      'retailerName': retailerName,
      'outstandingBalance': outstandingBalance,
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}
