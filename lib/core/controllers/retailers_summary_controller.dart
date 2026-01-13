import 'package:get/get.dart';
import '../../models/retailers_summary_model.dart';
import '../services/retailers_summary_service.dart';

class RetailersSummaryController extends GetxController {
  final RetailersSummaryService _service =
  Get.find<RetailersSummaryService>();

  final RxList<RetailersSummaryModel> summaries =
      <RetailersSummaryModel>[].obs;

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _bindSummaries();
  }

  void _bindSummaries() {
    isLoading.value = true;
    _service.streamSummaries().listen((data) {
      summaries.assignAll(data);
      isLoading.value = false;
    });
  }
}
