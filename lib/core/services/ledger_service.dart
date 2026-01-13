import 'package:uuid/uuid.dart';
import '../../models/ledger_entry_model.dart';
import '../../models/ledger_model.dart';
import '../../repositories/ledger_repository.dart';


class LedgerService {
  final LedgerRepository _repository = LedgerRepository();
  final Uuid _uuid = const Uuid();

  /// 📄 Get Ledger
  Future<LedgerModel?> getLedger(String retailerId) {
    return _repository.getLedger(retailerId);
  }

  /// ➕ Debit (SALE / PURCHASE)
  Future<void> addDebit({
    required String retailerId,
    required String retailerName,
    required double amount,
    required String referenceId,
  }) async {
    final existing =
    await _repository.getLedger(retailerId);

    final ledger = LedgerModel(
      id: existing?.id ?? _uuid.v4(),
      retailerId: retailerId,
      retailerName: retailerName,
      totalDebit: (existing?.totalDebit ?? 0) + amount,
      totalCredit: existing?.totalCredit ?? 0,
      balance: (existing?.balance ?? 0) + amount,
      updatedAt: DateTime.now(),
    );

    await _repository.saveLedger(ledger);

    await _repository.addEntry(
      LedgerEntryModel(
        id: _uuid.v4(),
        ledgerId: ledger.id,
        type: 'debit',
        amount: amount,
        referenceId: referenceId,
        date: DateTime.now(),
      ),
    );
  }

  /// ➖ Credit (PAYMENT)
  Future<void> addCredit({
    required String retailerId,
    required String retailerName,
    required double amount,
    required String referenceId,
  }) async {
    final existing =
    await _repository.getLedger(retailerId);

    final ledger = LedgerModel(
      id: existing?.id ?? _uuid.v4(),
      retailerId: retailerId,
      retailerName: retailerName,
      totalDebit: existing?.totalDebit ?? 0,
      totalCredit: (existing?.totalCredit ?? 0) + amount,
      balance: (existing?.balance ?? 0) - amount,
      updatedAt: DateTime.now(),
    );

    await _repository.saveLedger(ledger);

    await _repository.addEntry(
      LedgerEntryModel(
        id: _uuid.v4(),
        ledgerId: ledger.id,
        type: 'credit',
        amount: amount,
        referenceId: referenceId,
        date: DateTime.now(),
      ),
    );
  }

  /// 📄 Ledger Entries
  Stream<List<LedgerEntryModel>> entriesStream(
      String ledgerId) {
    return _repository.ledgerEntriesStream(ledgerId);
  }
}
