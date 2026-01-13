import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String _collection = 'products';

  // ================= STREAM ALL =================
  Stream<List<ProductModel>> streamProducts() {
    return _firestore
        .collection(_collection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProductModel.fromMap(
          doc.data(),
          doc.id,
        );
      }).toList();
    });
  }

  // ================= GET BY ID =================
  Future<ProductModel?> getById(String id) async {
    final doc =
    await _firestore.collection(_collection).doc(id).get();

    if (!doc.exists) return null;

    return ProductModel.fromMap(doc.data()!, doc.id);
  }

  // ================= CREATE / UPDATE =================
  Future<void> save(ProductModel product) async {
    await _firestore
        .collection(_collection)
        .doc(product.id)
        .set(product.toMap(), SetOptions(merge: true));
  }

  // ================= DELETE =================
  Future<void> delete(String id) async {
    await _firestore.collection(_collection).doc(id).delete();
  }
}
