import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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

  @override
  void onInit() {
    super.onInit();
    getMyOrders();
  }
  void getMyOrders() async {
    try {
      // Assuming NetworkRepository.getCategories returns a Future<dynamic>
      var responseData = await NetworkRepository.getMyOrders(party: '1',
      order_status: "",order_date: "",delivery_required_on: "",order_prifix: "");
      List myorders = responseData['body']['results'];
      myOrderList.assignAll(myorders);
      update();
      print('myOrderList++++ ${myOrderList.length}');
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
      myOrderDetailList.assignAll(myorders);
      update();
      print('myOrderDetailList++++ ${myOrderDetailList.length}');
    } catch (e) {
      errorMsg.value = e.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
  
}