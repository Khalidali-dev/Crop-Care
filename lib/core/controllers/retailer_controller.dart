import 'package:get/get.dart';
import '../../models/retailers_model.dart';

import '../services/retailers_service.dart';

class RetailerController extends GetxController {
  final RetailerService _service = Get.find<RetailerService>();

  final RxList<RetailerModel> retailers = <RetailerModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _bindRetailers();
  }

  void _bindRetailers() {
    isLoading.value = true;
    _service.getRetailers().listen((data) {
      retailers.assignAll(data);
      isLoading.value = false;
    });
  }

  Future<void> addRetailer({
    required String name,
    required String phone,
    required String address,
    required double openingBalance,
  }) async {
    await _service.createRetailer(
      name: name,
      phone: phone,
      address: address,
      openingBalance: openingBalance,
    );
  }

  Future<void> deleteRetailer(String id) async {
    await _service.deleteRetailer(id);
  }
}
