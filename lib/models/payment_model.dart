import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentModel {
  final String id;
  final String retailerId;
  final String retailerName;
  final double amount;
  final String method; // cash / bank / online
  final String reference;
  final DateTime date;
  final DateTime createdAt;

  PaymentModel({
    required this.id,
    required this.retailerId,
    required this.retailerName,
    required this.amount,
    required this.method,
    required this.reference,
    required this.date,
    required this.createdAt,
  });

  /// Firestore → Model
  factory PaymentModel.fromMap(String id, Map<String, dynamic> map) {
    return PaymentModel(
      id: id,
      retailerId: map['retailerId'],
      retailerName: map['retailerName'],
      amount: (map['amount'] ?? 0).toDouble(),
      method: map['method'],
      reference: map['reference'],
      date: (map['date'] as Timestamp).toDate(),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  /// Model → Firestore
  Map<String, dynamic> toMap() {
    return {
      'retailerId': retailerId,
      'retailerName': retailerName,
      'amount': amount,
      'method': method,
      'reference': reference,
      'date': Timestamp.fromDate(date),
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
