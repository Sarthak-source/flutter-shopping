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
    fetchPayments();
  }

  @override
  void onReady() {
    // fetchPopularDeals();
    super.onReady();
  }

  Future<dynamic> fetchPayments() async {
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

  Future<dynamic> addPayments(
      {required String invoice,
      required String amount,
      required String paymentMode,
      required String paymentDate,
      required String collectedBy}) async {
    try {
      //log(categoryId.toString());

      isLoading.value = true;
      var responseData = await NetworkRepository.addPayments(
          invoice: invoice,
          amount: amount,
          paymentMode: paymentMode,
          paymentDate: paymentDate,
          collectedBy: collectedBy);
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
