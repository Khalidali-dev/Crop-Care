import 'package:uuid/uuid.dart';
import '../../models/sales_model.dart';
import '../../repositories/sales_repository.dart';


class SalesService {
  final SalesRepository _repository = SalesRepository();
  final Uuid _uuid = const Uuid();

  /// ➕ Create Sale
  Future<void> createSale({
    required String productId,
    required String productName,
    required String retailerId,
    required String retailerName,
    required int quantity,
    required double price,
    required DateTime saleDate,
  }) async {
    final sale = SalesModel(
      id: _uuid.v4(),
      productId: productId,
      productName: productName,
      retailerId: retailerId,
      retailerName: retailerName,
      quantity: quantity,
      price: price,
      totalAmount: quantity * price,
      saleDate: saleDate,
      createdAt: DateTime.now(),
    );

    await _repository.addSale(sale);
  }

  /// 📄 Get Sales
  Stream<List<SalesModel>> getSales() {
    return _repository.streamSales();
  }

  /// ❌ Delete
  Future<void> deleteSale(String id) async {
    await _repository.deleteSale(id);
  }
}
