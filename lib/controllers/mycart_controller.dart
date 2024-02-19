import 'dart:developer';

import 'package:get/get.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

import '../screens/order_success_screen/order_success_screen.dart';

class MyCartController extends GetxController {

  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMsg = ''.obs;
  var mycartItems = [].obs;
  var myOrderItems = [].obs;
  var mycartTotalValue = "".obs;
  var mycartTotalGst = "".obs;
  var mycartTotalAmount = "".obs;

  @override
  void onInit() {
    super.onInit();
    getMyCart();
  }
  void updateCart(List newCartItems, responseData) {
   // mycartItems.value = newCartItems;
    log('cartitems inside my cart update fun :${newCartItems.length}');
    dynamic totalValue = responseData['body']['total_value'];
    dynamic totalGst =  responseData['body']['total_gst'];
    dynamic totalAmount = responseData['body']['total_amount'];
    mycartTotalValue =  RxString(totalValue.toString());
    mycartTotalGst = RxString(totalGst.toString());
    mycartTotalAmount =RxString(totalAmount.toString());
    mycartItems.assignAll(newCartItems);
    log('cartitems inside my cart update fun2 :${mycartItems.length}');
    update();// Update the cart items
  }
  void getMyCart() async {
    try {
      // Assuming NetworkRepository.getCategories returns a Future<dynamic>
      var responseData = await NetworkRepository.getMyCart(party: '1');
      List myCartData = responseData['body']['cart_list'];
      dynamic totalValue = responseData['body']['total_value'];
      dynamic totalGst =  responseData['body']['total_gst'];
      dynamic totalAmount = responseData['body']['total_amount'];
      mycartTotalValue =  RxString(totalValue.toString());
      mycartTotalGst = RxString(totalGst.toString());
      mycartTotalAmount =RxString(totalAmount.toString());
      mycartItems.assignAll(myCartData);
      log('mycartItems++++${mycartItems.length}');
    } catch (e) {
      errorMsg.value = e.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }


  void createOrderApi(party, shift, deliverydate,address) async {
    try {
      var responseData = await NetworkRepository.CreateOrderApi(
      party: "1",
      shift: "1",
      deliverydate: deliverydate,
      address: address);
      log('CreateOrderApiresponseData $responseData');

      List addToCartData = responseData['body'];
      myOrderItems.assignAll(addToCartData);
      update();
      if( myOrderItems.isNotEmpty){
        Get.toNamed(OrderSuccessScreen.routeName);
      }

      update(); // Notify observers about the change
    } catch (e) {
      log(e.toString());
      errorMsg.value = e.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

}