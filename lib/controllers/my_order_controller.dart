import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../config/common.dart';
import '../utils/network_repository.dart';


class MyOrderController extends GetxController{

  PageController pageController = PageController();
  RxInt selectedBtn = 0.obs;
  final RxList<bool> selectedFilter = <bool>[true, false, false, false].obs;
  final PagingController<int, dynamic> pagingController =
  PagingController(firstPageKey: 1);
  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMsg = ''.obs;
  var myOrderList = [].obs;
  var myOrderDetailList = [].obs;
  RxMap orderdetailDatas = {}.obs;

  @override
  void onInit() {
    super.onInit();
    getMyOrders("Created");

    print('selectedBtn in myorder controller ${selectedBtn.value}');
  }
  void getMyOrders(String status) async {
    try {
      // Assuming NetworkRepository.getCategories returns a Future<dynamic>
      Map storedUserData=box!.get('userData');


      var responseData = await NetworkRepository.getMyOrders(party: storedUserData['party']['id'].toString(),
      order_status: status,order_date: "",delivery_required_on: "",order_prifix: "");
      List myorders = responseData['body']['results'];
      myOrderList.assignAll(myorders);
      update();
      log('myOrderList++++ ${myOrderList.length}');
    } catch (e) {
      errorMsg.value = e.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  void getMyOrdersDetail(String orderId) async {
    try {
       isLoading.value = true;
      // Assuming NetworkRepository.getCategories returns a Future<dynamic>
      var responseData = await NetworkRepository.getOrderDetail(orderId: orderId);
      List myorders = responseData['body']['order_items'];
       String jsonString = jsonEncode(responseData['body']);
       Map<String, dynamic> data = jsonDecode(jsonString);
       String addressLine1 = data['address']['address_line1'];
       log("address from myorderdetail $addressLine1");
       orderdetailDatas = RxMap(data);
       log("address from myorderdetail2 ${orderdetailDatas['address']['address_line1']}");
      myOrderDetailList.assignAll(myorders);
      update();
      log('myOrderDetailList++++ ${myOrderDetailList.length}');
    } catch (e) {
      errorMsg.value = e.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
  
}