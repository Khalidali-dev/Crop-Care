import 'package:uuid/uuid.dart';
import '../../models/retailers_model.dart';
import '../../repositories/retailers_repository.dart';

class RetailerService {
  final RetailerRepository _repository = RetailerRepository();
  final Uuid _uuid = const Uuid();

  /// ➕ Create Retailer
  Future<void> createRetailer({
    required String name,
    required String phone,
    required String address,
    required double openingBalance,
  }) async {
    final retailer = RetailerModel(
      id: _uuid.v4(),
      name: name,
      phone: phone,
      address: address,
      openingBalance: openingBalance,
      createdAt: DateTime.now(),
    );

    await _repository.addRetailer(retailer);
  }

  /// 📄 Get Retailers
  Stream<List<RetailerModel>> getRetailers() {
    return _repository.streamRetailers();
  }

  /// ❌ Delete
  Future<void> deleteRetailer(String id) async {
    await _repository.deleteRetailer(id);
  }
}
