import 'dart:developer';

import 'package:get/get.dart';
import 'package:sutra_ecommerce/config/common.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

class PaymentController extends GetxController {
  var payment = [].obs;

  var invoicesList = [].obs;

  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMsg = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPayments();
    fetchInvoice();
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
          dispatchParty: storedUserData['party']['id'].toString());
      log("paymentData ${responseData.toString()}");
      List paymentData = responseData['body']['results'];
      log(paymentData.toString());
      payment.value = paymentData;
      log(payment.toString());
    } catch (e) {
      errorMsg.value = e.toString();
      log("paymentDataError ${e.toString()}");
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> fetchInvoice() async {
    try {
      Map storedUserData = box!.get('userData');

      //log(categoryId.toString());

      isLoading.value = true;
      var responseData = await NetworkRepository.invoiceList(
          storedUserData['party']['id'].toString());
      List invoicesDataList = responseData['body'][0]['invoice_items'];
      invoicesList.value = invoicesDataList;
      //log(invoicesList.toString());
    } catch (e) {
      errorMsg.value = e.toString();
      log('invoice ${e.toString()}');
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
      required String status,
      required String collectedBy}) async {
    try {
      //log(categoryId.toString());

      isLoading.value = true;
      var responseData = await NetworkRepository.addPayments(
          invoice: invoice,
          amount: amount,
          paymentMode: paymentMode,
          paymentDate: paymentDate,
          collectedBy: collectedBy,
          status: status);
      var popularDealData = responseData;

      log(popularDealData.toString());
    } catch (e) {
      errorMsg.value = e.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}
