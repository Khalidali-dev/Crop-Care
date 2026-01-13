import 'package:get/get.dart';
import '../../models/product_model.dart';

import '../services/product_service.dart';

class ProductController extends GetxController {
  final ProductService _service = Get.find<ProductService>();

  final RxList<ProductModel> products = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _bindProducts();
  }

  void _bindProducts() {
    _service.streamProducts().listen((data) {
      products.value = data;
    });
  }

  Future<void> deleteProduct(String id) async {
    await _service.deleteProduct(id);
  }
}
