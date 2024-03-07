import 'dart:developer';

import 'package:get/get.dart';
import 'package:sutra_ecommerce/config/common.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

class PaymentController extends GetxController {
  var payment = [].obs;

  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMsg = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPopularDeals();
  }

  @override
  void onReady() {
    // fetchPopularDeals();
    super.onReady();
  }

  Future<dynamic> fetchPopularDeals() async {
    try {
      Map storedUserData = box!.get('userData');

      //log(categoryId.toString());

      isLoading.value = true;
      var responseData = await NetworkRepository.getPayments(
          dispatchParty: storedUserData['party']['id']);
      List popularDealData = responseData['body']['results'];
      payment.value = popularDealData;
      log(payment.toString());
    } catch (e) {
      errorMsg.value = e.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}
