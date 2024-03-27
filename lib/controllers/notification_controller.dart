import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/config/common.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

class NotificationController extends GetxController {
  var notification = [].obs;

  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMsg = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchInvoiceNotification();
  }

  @override
  void onReady() {
    // fetchPopularDeals();
    super.onReady();
  }

  Future<dynamic> fetchInvoiceNotification() async {
    try {
      Map storedUserData = box!.get('userData');

      isLoading.value = true;
      var responseData = await NetworkRepository.getInvoiceNotification(
          dispatchParty: storedUserData['party']['id'].toString());
      List popularDealData = responseData['body']['results'];
      log(popularDealData.toString());
      notification.assignAll(popularDealData);
      update();
      log(notification.toString());
    } catch (e) {
      errorMsg.value = e.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> setStatusNotification(  String status, String invoiceId,) async {
    try {
      Map storedUserData = box!.get('userData');

      isLoading.value = true;
      var responseData = await NetworkRepository.confirmInovice(status: status, invoiceId: invoiceId);

      update();
       Fluttertoast.showToast(msg: "updated", backgroundColor: Colors.green);

    } catch (e) {
      errorMsg.value = e.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
     
      Get.back();

    }
  }

}
