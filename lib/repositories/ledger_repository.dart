import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/ledger_model.dart';
import '../models/ledger_entry_model.dart';

class LedgerRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String _ledgerCol = 'ledgers';
  static const String _entriesCol = 'ledger_entries';

  /// 📄 Get Ledger By Retailer
  Future<LedgerModel?> getLedger(String retailerId) async {
    final query = await _firestore
        .collection(_ledgerCol)
        .where('retailerId', isEqualTo: retailerId)
        .limit(1)
        .get();

    if (query.docs.isEmpty) return null;

    final doc = query.docs.first;
    return LedgerModel.fromMap(doc.id, doc.data());
  }

  /// 💾 Save Ledger
  Future<void> saveLedger(LedgerModel model) async {
    await _firestore
        .collection(_ledgerCol)
        .doc(model.id)
        .set(model.toMap(), SetOptions(merge: true));
  }

  /// ➕ Add Ledger Entry
  Future<void> addEntry(LedgerEntryModel entry) async {
    await _firestore
        .collection(_entriesCol)
        .doc(entry.id)
        .set(entry.toMap());
  }

  /// 📄 Ledger Entries Stream
  Stream<List<LedgerEntryModel>> ledgerEntriesStream(
      String ledgerId) {
    return _firestore
        .collection(_entriesCol)
        .where('ledgerId', isEqualTo: ledgerId)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) =>
          LedgerEntryModel.fromMap(doc.id, doc.data()))
          .toList();
    });
  }
}
