import 'package:uuid/uuid.dart';
import '../../models/purchase_model.dart';
import '../../repositories/purchase_repository.dart';


class PurchaseService {
  final PurchaseRepository _repository = PurchaseRepository();
  final Uuid _uuid = const Uuid();

  /// ➕ Create Purchase
  Future<void> createPurchase({
    required String productId,
    required String productName,
    required int quantity,
    required double price,
    required String supplierName,
    required DateTime purchaseDate,
  }) async {
    final purchase = PurchaseModel(
      id: _uuid.v4(),
      productId: productId,
      productName: productName,
      quantity: quantity,
      price: price,
      totalAmount: quantity * price,
      purchaseDate: purchaseDate,
      supplierName: supplierName,
      createdAt: DateTime.now(),
    );

    await _repository.addPurchase(purchase);
  }

  /// 📄 Stream Purchases
  Stream<List<PurchaseModel>> getPurchases() {
    return _repository.streamPurchases();
  }

  /// ❌ Delete
  Future<void> deletePurchase(String id) async {
    await _repository.deletePurchase(id);
  }
}
