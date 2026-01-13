import 'package:cloud_firestore/cloud_firestore.dart';

class SalesModel {
  final String id;
  final String productId;
  final String productName;
  final String retailerId;
  final String retailerName;
  final int quantity;
  final double price;
  final double totalAmount;
  final DateTime saleDate;
  final DateTime createdAt;

  SalesModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.retailerId,
    required this.retailerName,
    required this.quantity,
    required this.price,
    required this.totalAmount,
    required this.saleDate,
    required this.createdAt,
  });

  /// 🔁 Firestore → Model
  factory SalesModel.fromMap(String id, Map<String, dynamic> map) {
    return SalesModel(
      id: id,
      productId: map['productId'] ?? '',
      productName: map['productName'] ?? '',
      retailerId: map['retailerId'] ?? '',
      retailerName: map['retailerName'] ?? '',
      quantity: map['quantity'] ?? 0,
      price: (map['price'] ?? 0).toDouble(),
      totalAmount: (map['totalAmount'] ?? 0).toDouble(),
      saleDate: (map['saleDate'] as Timestamp).toDate(),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  /// 🔁 Model → Firestore
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'retailerId': retailerId,
      'retailerName': retailerName,
      'quantity': quantity,
      'price': price,
      'totalAmount': totalAmount,
      'saleDate': Timestamp.fromDate(saleDate),
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
