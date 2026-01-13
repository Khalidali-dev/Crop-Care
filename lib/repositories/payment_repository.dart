import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/payment_model.dart';

class PaymentRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collection = 'payments';

  /// ➕ Add Payment
  Future<void> addPayment(PaymentModel payment) async {
    await _firestore
        .collection(_collection)
        .doc(payment.id)
        .set(payment.toMap());
  }

  /// 📄 Stream All Payments
  Stream<List<PaymentModel>> streamPayments() {
    return _firestore
        .collection(_collection)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => PaymentModel.fromMap(doc.id, doc.data()))
          .toList();
    });
  }

  /// 📄 Stream Retailer Payments
  Stream<List<PaymentModel>> streamPaymentsByRetailer(String retailerId) {
    return _firestore
        .collection(_collection)
        .where('retailerId', isEqualTo: retailerId)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => PaymentModel.fromMap(doc.id, doc.data()))
          .toList();
    });
  }
}
