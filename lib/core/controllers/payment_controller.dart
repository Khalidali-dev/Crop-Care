import 'package:get/get.dart';
import '../../models/payment_model.dart';

import '../services/payment_service.dart';

class PaymentController extends GetxController {
  final PaymentService _service = Get.find<PaymentService>();

  final RxList<PaymentModel> payments = <PaymentModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _bindPayments();
  }

  void _bindPayments() {
    isLoading.value = true;
    _service.getPayments().listen((data) {
      payments.assignAll(data);
      isLoading.value = false;
    });
  }

  Future<void> addPayment({
    required String retailerId,
    required String retailerName,
    required double amount,
    required String method,
    String reference = '',
    required DateTime date,
  }) async {
    await _service.createPayment(
      retailerId: retailerId,
      retailerName: retailerName,
      amount: amount,
      method: method,
      reference: reference,
      date: date,
    );
  }
}
