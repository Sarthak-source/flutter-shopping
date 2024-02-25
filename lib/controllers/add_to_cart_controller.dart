import 'dart:developer';

import 'package:get/get.dart';
import 'package:sutra_ecommerce/controllers/mycart_controller.dart';
import 'package:sutra_ecommerce/controllers/popular_deals.dart';
import 'package:sutra_ecommerce/controllers/user_controller.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

import '../config/common.dart';

class AddToCartController extends GetxController {
  //final UserController userController = Get.put(UserController());
  final MyCartController cartController = Get.find();
  final PopularDealController popController = Get.find();

  RxInt productCount = 0.obs;
  @override
  void onInit() {
    // Get called when controller is created
    // productCount.value =
    //     userController.user['party']['party_cart_count'].toInt();

    // log("productCount ${productCount.value.toString()}");
    super.onInit();
  }

  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMsg = ''.obs;
  var myUpdatecartItems = [].obs;

  RxList addToCartList = [].obs;
  //int intialProductCount=userController.user[''];

  void updateCartData(List newCartItems, responseData) {
    print('cartitems inside update fun :${newCartItems.length}');

    cartController.updateCart(newCartItems,
        responseData); // Call the method in CartController to update cart data
    if(newCartItems.length ==0){
      print('newcart length zero${newCartItems.length}');
      productCount.value=0;
    }
    for(var i =0; i<=newCartItems.length ; i++){
      print('newCartItems count ${newCartItems[i]['party_cart_count']}');

        productCount.value=newCartItems[i]['party_cart_count'].toInt();


        }
  }

  void addToCart(count, product, party) async {
    try {
      Map storedUserData=box!.get('userData');


      var responseData = await NetworkRepository.addToCart(
          count: count.toString(),
          product: product.toString(),
          party: storedUserData['party']['id'].toString());
      log('responseData $responseData');

      var addToCartData = responseData;
      addToCartList.add(addToCartData);

      // Update productCount value
      log(productCount.value.toString());
      update(); // Notify observers about the change
      cartController.getMyCart();
      popController.fetchPopularDeals();
      popController.update();
      //productCount.value = double.parse((productCount.value/2).toString()).toInt() + double.parse(count).toInt();
    } catch (e) {
      log(e.toString());
      errorMsg.value = e.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  void updateCart(count, cart, type, party) async {
    try {
      Map storedUserData=box!.get('userData');
      var responseData = await NetworkRepository.UpdateCart(
          count: count.toString(),
          cart: cart.toString(),
          type: type.toString(),
          party: storedUserData['party']['id'].toString());
      log('responseData $responseData');

      //var addToCartData = responseData;
      List myCartData = responseData['body']['cart_list'];
      myUpdatecartItems.addAll(myCartData);
      update();

      print('myUpdatecartItems==>> ${myUpdatecartItems.length}');
      updateCartData(myCartData, responseData);
      //  cartController.mycartItems.add(addToCartData);
      cartController.update();
      // mycartItems.add(addToCartData);
    } catch (e) {
      log(e.toString());
      errorMsg.value = e.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}

class StoreBinding implements Bindings {
// default dependency
  @override
  void dependencies() {
    Get.lazyPut(() => AddToCartController());
    Get.lazyPut(() => MyCartController());
    Get.lazyPut(() => UserController());
    Get.lazyPut(() => PopularDealController());
  }


}
