import 'dart:developer';

import 'package:get/get.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

class DealsController extends GetxController {
  // Change RxString to regular String

  DealsController();

  var deals = [].obs;

  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMsg = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDealss();
  }
  @override
  void onReady() {
    print('ControllerTwo onReady');
   // fetchDealss();
    super.onReady();
  }

  Future<dynamic> fetchDealss() async {
    try {
      var responseData = await NetworkRepository.getDeals();
      List dealsData = responseData['body']['results'];
      log(dealsData.toString());
      deals.assignAll(dealsData);
      update();
    } catch (e) {
      errorMsg.value = e.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}
