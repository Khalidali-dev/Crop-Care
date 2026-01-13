import 'package:get/get.dart';
import '../../models/purchase_model.dart';

import '../services/purchase_service.dart';

class PurchaseController extends GetxController {
  final PurchaseService _service = Get.find<PurchaseService>();

  final RxList<PurchaseModel> purchases = <PurchaseModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _bindPurchases();
  }

  void _bindPurchases() {
    isLoading.value = true;
    _service.getPurchases().listen((data) {
      purchases.assignAll(data);
      isLoading.value = false;
    });
  }

  Future<void> addPurchase({
    required String productId,
    required String productName,
    required int quantity,
    required double price,
    required String supplierName,
    required DateTime purchaseDate,
  }) async {
    await _service.createPurchase(
      productId: productId,
      productName: productName,
      quantity: quantity,
      price: price,
      supplierName: supplierName,
      purchaseDate: purchaseDate,
    );
  }

  Future<void> deletePurchase(String id) async {
    await _service.deletePurchase(id);
  }
}
