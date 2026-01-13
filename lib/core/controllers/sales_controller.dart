import 'package:get/get.dart';
import '../../models/sales_model.dart';

import '../services/sales_service.dart';

class SalesController extends GetxController {
  final SalesService _service = Get.find<SalesService>();

  final RxList<SalesModel> sales = <SalesModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _bindSales();
  }

  void _bindSales() {
    isLoading.value = true;
    _service.getSales().listen((data) {
      sales.assignAll(data);
      isLoading.value = false;
    });
  }

  Future<void> addSale({
    required String productId,
    required String productName,
    required String retailerId,
    required String retailerName,
    required int quantity,
    required double price,
    required DateTime saleDate,
  }) async {
    await _service.createSale(
      productId: productId,
      productName: productName,
      retailerId: retailerId,
      retailerName: retailerName,
      quantity: quantity,
      price: price,
      saleDate: saleDate,
    );
  }

  Future<void> deleteSale(String id) async {
    await _service.deleteSale(id);
  }
}
