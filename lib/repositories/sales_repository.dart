import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/sales_model.dart';

class SalesRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collection = 'sales';

  /// ➕ Add Sale
  Future<void> addSale(SalesModel sale) async {
    await _firestore
        .collection(_collection)
        .doc(sale.id)
        .set(sale.toMap());
  }

  /// 📄 Stream Sales
  Stream<List<SalesModel>> streamSales() {
    return _firestore
        .collection(_collection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => SalesModel.fromMap(doc.id, doc.data()))
          .toList();
    });
  }

  /// ❌ Delete Sale
  Future<void> deleteSale(String id) async {
    await _firestore.collection(_collection).doc(id).delete();
  }
}
