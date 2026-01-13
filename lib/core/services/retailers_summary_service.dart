import 'package:uuid/uuid.dart';
import '../../models/retailers_summary_model.dart';
import '../../repositories/retailers_summary_repository.dart';


class RetailersSummaryService {
  final RetailersSummaryRepository _repository =
  RetailersSummaryRepository();
  final Uuid _uuid = const Uuid();

  /// 📄 All Summaries
  Stream<List<RetailersSummaryModel>> streamSummaries() {
    return _repository.streamSummaries();
  }

  /// 🔄 Update After SALE
  Future<void> addSale({
    required String retailerId,
    required String retailerName,
    required double amount,
  }) async {
    final existing =
    await _repository.getByRetailer(retailerId);

    final model = RetailersSummaryModel(
      id: existing?.id ?? _uuid.v4(),
      retailerId: retailerId,
      retailerName: retailerName,
      totalSales: (existing?.totalSales ?? 0) + amount,
      totalPayments: existing?.totalPayments ?? 0,
      outstandingBalance:
      (existing?.outstandingBalance ?? 0) + amount,
      updatedAt: DateTime.now(),
    );

    await _repository.saveSummary(model);
  }

  /// 🔄 Update After PAYMENT
  Future<void> addPayment({
    required String retailerId,
    required String retailerName,
    required double amount,
  }) async {
    final existing =
    await _repository.getByRetailer(retailerId);

    final model = RetailersSummaryModel(
      id: existing?.id ?? _uuid.v4(),
      retailerId: retailerId,
      retailerName: retailerName,
      totalSales: existing?.totalSales ?? 0,
      totalPayments: (existing?.totalPayments ?? 0) + amount,
      outstandingBalance:
      (existing?.outstandingBalance ?? 0) - amount,
      updatedAt: DateTime.now(),
    );

    await _repository.saveSummary(model);
  }
}
