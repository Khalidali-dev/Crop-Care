import 'package:cloud_firestore/cloud_firestore.dart';

class PurchaseModel {
  final String id;
  final String productId;
  final String productName;
  final int quantity;
  final double price;
  final double totalAmount;
  final DateTime purchaseDate;
  final String supplierName;
  final DateTime createdAt;

  PurchaseModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.totalAmount,
    required this.purchaseDate,
    required this.supplierName,
    required this.createdAt,
  });

  /// 🔁 Firestore → Model
  factory PurchaseModel.fromMap(String id, Map<String, dynamic> map) {
    return PurchaseModel(
      id: id,
      productId: map['productId'] ?? '',
      productName: map['productName'] ?? '',
      quantity: map['quantity'] ?? 0,
      price: (map['price'] ?? 0).toDouble(),
      totalAmount: (map['totalAmount'] ?? 0).toDouble(),
      purchaseDate: (map['purchaseDate'] as Timestamp).toDate(),
      supplierName: map['supplierName'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  /// 🔁 Model → Firestore
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'price': price,
      'totalAmount': totalAmount,
      'purchaseDate': Timestamp.fromDate(purchaseDate),
      'supplierName': supplierName,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
