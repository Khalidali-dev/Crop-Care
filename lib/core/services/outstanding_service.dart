import 'package:uuid/uuid.dart';
import '../../models/outstanding_model.dart';
import '../../repositories/outstanding_repository.dart';


class OutstandingService {
  final OutstandingRepository _repository = OutstandingRepository();
  final Uuid _uuid = const Uuid();

  /// 📄 All Outstanding
  Stream<List<OutstandingModel>> getOutstandingList() {
    return _repository.streamOutstanding();
  }

  /// ➕ Increase Outstanding (Sales)
  Future<void> increaseOutstanding({
    required String retailerId,
    required String retailerName,
    required double amount,
  }) async {
    final existing = await _repository.getByRetailer(retailerId);

    final newBalance =
        (existing?.outstandingBalance ?? 0) + amount;

    final model = OutstandingModel(
      id: existing?.id ?? _uuid.v4(),
      retailerId: retailerId,
      retailerName: retailerName,
      outstandingBalance: newBalance,
      updatedAt: DateTime.now(),
    );

    await _repository.saveOutstanding(model);
  }

  /// ➖ Decrease Outstanding (Payment)
  Future<void> decreaseOutstanding({
    required String retailerId,
    required String retailerName,
    required double amount,
  }) async {
    final existing = await _repository.getByRetailer(retailerId);

    final newBalance =
        (existing?.outstandingBalance ?? 0) - amount;

    final model = OutstandingModel(
      id: existing?.id ?? _uuid.v4(),
      retailerId: retailerId,
      retailerName: retailerName,
      outstandingBalance: newBalance < 0 ? 0 : newBalance,
      updatedAt: DateTime.now(),
    );

    await _repository.saveOutstanding(model);
  }
}
