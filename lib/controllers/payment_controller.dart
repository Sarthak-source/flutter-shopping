import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/config/common.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

import '../screens/paymentScreen/paymentScreen.dart';

class PaymentController extends GetxController {
  var payment = [].obs;

  var invoicesList = [].obs;

  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMsg = ''.obs;
  var cod = false.obs;
  var upi = false.obs;
  var showUpi = false.obs;
  @override
  void onInit() {
    super.onInit();
    //fetchPayments();
    //fetchInvoice();
  }

  @override
  void onReady() {
    // fetchPopularDeals();
    //fetchPayments();
    //fetchInvoice();
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
      required String collectedBy,
      required String transId,
      }) async {
    try {
      //log(categoryId.toString());

      isLoading.value = true;
      var responseData = await NetworkRepository.addPayments(
          invoice: invoice,
          amount: amount,
          paymentMode: paymentMode,
          paymentDate: paymentDate,
          collectedBy: collectedBy,
          status: status,
          transId: transId);
      var popularDealData = responseData;

      update();
      log(popularDealData.toString());
    } catch (e) {
      errorMsg.value = e.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
      Fluttertoast.showToast(
        msg: 'Payment Added Successfully!',
        backgroundColor: Colors.green,
      );
     // Get.toNamed(PaymentScreen.routeName);
      Get.back();
    }
  }
}
