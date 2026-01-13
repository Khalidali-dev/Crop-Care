import 'package:get/get.dart';
import '../services/sync_service.dart';

class ServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SyncService>(SyncService(), permanent: true);
  }
}
