import 'package:get/get.dart';
import '../../models/outstanding_model.dart';

import '../services/outstanding_service.dart';

class OutstandingController extends GetxController {
  final OutstandingService _service = Get.find<OutstandingService>();

  final RxList<OutstandingModel> outstandingList =
      <OutstandingModel>[].obs;

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _bindOutstanding();
  }

  void _bindOutstanding() {
    isLoading.value = true;
    _service.getOutstandingList().listen((data) {
      outstandingList.assignAll(data);
      isLoading.value = false;
    });
  }
}
