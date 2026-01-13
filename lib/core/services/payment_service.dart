import 'package:uuid/uuid.dart';
import '../../models/payment_model.dart';
import '../../repositories/payment_repository.dart';


class PaymentService {
  final PaymentRepository _repository = PaymentRepository();
  final Uuid _uuid = const Uuid();

  /// ➕ Create Payment
  Future<void> createPayment({
    required String retailerId,
    required String retailerName,
    required double amount,
    required String method,
    String reference = '',
    required DateTime date,
  }) async {
    final payment = PaymentModel(
      id: _uuid.v4(),
      retailerId: retailerId,
      retailerName: retailerName,
      amount: amount,
      method: method,
      reference: reference,
      date: date,
      createdAt: DateTime.now(),
    );

    await _repository.addPayment(payment);
  }

  /// 📄 All Payments
  Stream<List<PaymentModel>> getPayments() {
    return _repository.streamPayments();
  }

  /// 📄 Retailer Payments
  Stream<List<PaymentModel>> getPaymentsByRetailer(String retailerId) {
    return _repository.streamPaymentsByRetailer(retailerId);
  }
}
