import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:sutra_ecommerce/controllers/popular_controller.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

import '../config/common.dart';
import '../hive_models/Orders/create_order.dart';
import '../screens/order_success_screen/order_success_screen.dart';

class MyCartController extends GetxController {
  // AddToCartController addToCardController =Get.find();
  final PopularDealController popController = Get.put(PopularDealController(categoryId: ''));
  var isLoading = true.obs;
  var isOrderCreated = false.obs;
  var hasError = false.obs;
  var errorMsg = ''.obs;
  var mycartItems = [].obs;
  var myOrderItems = [].obs;
  var mycartTotalValue = "".obs;
  var mycartTotalGst = "".obs;
  var mycartTotalAmount = "0".obs;
  Box<CreateOrderModel>? createOrderBoxCLR;
  List<CreateOrderModel>? catModelListCLR = [];
  @override
  void onInit() {
    super.onInit();
    getMyCart();
  }

  void updateCart(List newCartItems, responseData) {
    // mycartItems.value = newCartItems;
    log('cartitems inside my cart update fun :${newCartItems.length}');
    dynamic totalValue = responseData['body']['total_value'];
    dynamic totalGst = responseData['body']['total_gst'];
    dynamic totalAmount = responseData['body']['total_amount'];
    mycartTotalValue = RxString(totalValue.toString());
    mycartTotalGst = RxString(totalGst.toString());
    mycartTotalAmount = RxString(totalAmount.toString());

    mycartItems.assignAll(newCartItems);
    popController.fetchPopularDeals();
    /*  for(var i =0; i<newCartItems.length ; i++){
      if(newCartItems.isNotEmpty){
        addToCardController.productCount.value=newCartItems[i]['party_cart_count'].toInt();
      }
    }*/
    log('cartitems inside my cart update fun2 :${mycartItems.length}');
    update(); // Update the cart items
  }

  void getMyCart() async {
    try {
      // Assuming NetworkRepository.getCategories returns a Future<dynamic>
      Map storedUserData = box!.get('userData');
      isLoading.value =true;
      update();
      print('userdata in mycart ${storedUserData['party']['id'].toString()}');
      var responseData = await NetworkRepository.getMyCart(
          party: storedUserData['party']['id'].toString());
      List myCartData = responseData['body']['cart_list'];
      log(myCartData.toString());
      dynamic totalValue = responseData['body']['total_value'];
      dynamic totalGst = responseData['body']['total_gst'];
      dynamic totalAmount = responseData['body']['total_amount'];
      log("hello $totalAmount");
      Map userData = responseData['body'];

      // for(List item in myCartData){
      /*   for(var i =0; i<myCartData.length ; i++){
        if(myCartData.isNotEmpty){
          addToCardController.productCount.value=myCartData[i]['party_cart_count'].toInt();
        }
      }*/

      mycartTotalValue = RxString(totalValue.toString());
      mycartTotalGst = RxString(totalGst.toString());
      mycartTotalAmount.value = totalAmount.toString();
      mycartItems.assignAll(myCartData);
      log('mycartItems++++${mycartItems.length} ${mycartTotalAmount.value}');
    } catch (e) {
      errorMsg.value = e.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
      update();
    }
  }

  void createOrderApi( shift, deliverydate, address,
      String amtPaid,
       String payMode,
       String upiId,
       String upiTransId,
       String upiTransSts,
       Function(bool) onSuccessRes,) async {
    try {
      isLoading.value = true;
      Map storedUserData = box!.get('userData');
      print('storedUserData in create order ${storedUserData['party']['id'].toString()}');

      var responseData = await NetworkRepository.CreateOrderApi(
          party: storedUserData['party']['id'].toString(),
          shift: "1",
          deliverydate: deliverydate,
          address: address,
        amtPaid: amtPaid,
        payMode: payMode,
        upiId:upiId ,
        upiTransId: upiTransId,
        upiTransSts: upiTransSts
      );
      log('CreateOrderApiresponseData $responseData');

      List addToCartData = responseData['body'];
      myOrderItems.assignAll(addToCartData);
      update();
      if (myOrderItems.isNotEmpty) {
        isOrderCreated.value = true;
        update();
        getMyCart();
        popController.fetchPopularDeals();
        onSuccessRes(true);
        // createOrderBoxCLR?.delete("createorder");
        // catModelListCLR = createOrderBoxCLR?.values.toList();
        // print('after success:: ${catModelListCLR?.length}');

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
