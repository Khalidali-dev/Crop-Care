import 'package:cloud_firestore/cloud_firestore.dart';

class LedgerModel {
  final String id;
  final String retailerId;
  final String retailerName;
  final double totalDebit;
  final double totalCredit;
  final double balance;
  final DateTime updatedAt;

  LedgerModel({
    required this.id,
    required this.retailerId,
    required this.retailerName,
    required this.totalDebit,
    required this.totalCredit,
    required this.balance,
    required this.updatedAt,
  });

  factory LedgerModel.fromMap(String id, Map<String, dynamic> map) {
    return LedgerModel(
      id: id,
      retailerId: map['retailerId'],
      retailerName: map['retailerName'],
      totalDebit: (map['totalDebit'] ?? 0).toDouble(),
      totalCredit: (map['totalCredit'] ?? 0).toDouble(),
      balance: (map['balance'] ?? 0).toDouble(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'retailerId': retailerId,
      'retailerName': retailerName,
      'totalDebit': totalDebit,
      'totalCredit': totalCredit,
      'balance': balance,
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}
