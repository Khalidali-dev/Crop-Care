import 'package:cloud_firestore/cloud_firestore.dart';

class RetailersSummaryModel {
  final String id;
  final String retailerId;
  final String retailerName;
  final double totalSales;
  final double totalPayments;
  final double outstandingBalance;
  final DateTime updatedAt;

  RetailersSummaryModel({
    required this.id,
    required this.retailerId,
    required this.retailerName,
    required this.totalSales,
    required this.totalPayments,
    required this.outstandingBalance,
    required this.updatedAt,
  });

  factory RetailersSummaryModel.fromMap(String id, Map<String, dynamic> map) {
    return RetailersSummaryModel(
      id: id,
      retailerId: map['retailerId']?.toString() ?? '',
      retailerName: map['retailerName']?.toString() ?? '',
      totalSales: _parseDouble(map['totalSales']),
      totalPayments: _parseDouble(map['totalPayments']),
      outstandingBalance: _parseDouble(map['outstandingBalance']),
      updatedAt: _parseDateTime(map['updatedAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'retailerId': retailerId,
      'retailerName': retailerName,
      'totalSales': totalSales,
      'totalPayments': totalPayments,
      'outstandingBalance': outstandingBalance,
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      try {
        return double.parse(value);
      } catch (e) {
        return 0.0;
      }
    }
    return 0.0;
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value == null) return DateTime.now();

    if (value is Timestamp) {
      return value.toDate();
    }

    if (value is DateTime) {
      return value;
    }

    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (e) {
        return DateTime.now();
      }
    }

    if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    }

    return DateTime.now();
  }
}
