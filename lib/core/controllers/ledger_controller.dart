import 'package:get/get.dart';
import '../../models/ledger_entry_model.dart';
import '../../models/ledger_model.dart';

import '../services/ledger_service.dart';

class LedgerController extends GetxController {
  final LedgerService _service = Get.find<LedgerService>();

  final Rx<LedgerModel?> ledger = Rx<LedgerModel?>(null);
  final RxList<LedgerEntryModel> entries =
      <LedgerEntryModel>[].obs;

  final RxBool isLoading = false.obs;

  Future<void> loadLedger(String retailerId) async {
    isLoading.value = true;
    ledger.value = await _service.getLedger(retailerId);
    isLoading.value = false;

    if (ledger.value != null) {
      _service
          .entriesStream(ledger.value!.id)
          .listen(entries.assignAll);
    }
  }
}
