import 'package:cloud_firestore/cloud_firestore.dart';

class LedgerEntryModel {
  final String id;
  final String ledgerId;
  final String type; // debit | credit
  final double amount;
  final String referenceId;
  final DateTime date;

  LedgerEntryModel({
    required this.id,
    required this.ledgerId,
    required this.type,
    required this.amount,
    required this.referenceId,
    required this.date,
  });

  factory LedgerEntryModel.fromMap(
      String id, Map<String, dynamic> map) {
    return LedgerEntryModel(
      id: id,
      ledgerId: map['ledgerId'],
      type: map['type'],
      amount: (map['amount'] ?? 0).toDouble(),
      referenceId: map['referenceId'],
      date: (map['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ledgerId': ledgerId,
      'type': type,
      'amount': amount,
      'referenceId': referenceId,
      'date': Timestamp.fromDate(date),
    };
  }
}
