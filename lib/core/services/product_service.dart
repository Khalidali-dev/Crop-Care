import 'package:get/get.dart';
import '../../models/product_model.dart';
import '../../repositories/product_repository.dart';


class ProductService extends GetxService {
  final ProductRepository _repo = ProductRepository();

  // ================= STREAM =================
  Stream<List<ProductModel>> streamProducts() {
    return _repo.streamProducts();
  }

  // ================= GET =================
  Future<ProductModel?> getProduct(String id) {
    return _repo.getById(id);
  }

  // ================= ADD / UPDATE =================
  Future<void> saveProduct({
    required String id,
    required String name,
    required String category,
    required double price,
    required int stock,
    bool isActive = true,
  }) async {
    final product = ProductModel(
      id: id,
      name: name,
      category: category,
      price: price,
      stock: stock,
      isActive: isActive,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _repo.save(product);
  }

  // ================= DELETE =================
  Future<void> deleteProduct(String id) async {
    await _repo.delete(id);
  }
}
