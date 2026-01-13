import 'package:cloud_firestore/cloud_firestore.dart';

class RetailerModel {
  final String id;
  final String name;
  final String phone;
  final String address;
  final double openingBalance;
  final DateTime createdAt;

  RetailerModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.openingBalance,
    required this.createdAt,
  });

  factory RetailerModel.fromMap(String id, Map<String, dynamic> map) {
    return RetailerModel(
      id: id,
      name: map['name']?.toString() ?? '',
      phone: map['phone']?.toString() ?? '',
      address: map['address']?.toString() ?? '',
      openingBalance: _parseDouble(map['openingBalance']),
      createdAt: _parseDateTime(map['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'openingBalance': openingBalance,
      'createdAt': Timestamp.fromDate(createdAt),
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
