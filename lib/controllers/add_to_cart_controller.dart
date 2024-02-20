import 'dart:developer';

import 'package:get/get.dart';
import 'package:sutra_ecommerce/controllers/user_controller.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

class AddToCartController extends GetxController {
  final UserController userController = Get.find<UserController>();
  RxInt productCount = 0.obs;
  @override
  void onInit() {
    // Get called when controller is created
    productCount.value=  userController.user['party']['party_cart_count'].toInt();
    super.onInit();
  }

  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMsg = ''.obs;
  RxList addToCartList = [].obs;
  //int intialProductCount=userController.user[''];
  

  void addToCart(count, product, party) async {
    try {
      var responseData = await NetworkRepository.addToCart(
          count: count.toString(),
          product: product.toString(),
          party: party.toString());
      log('responseData $responseData');

      var addToCartData = responseData;
      addToCartList.add(addToCartData);

      productCount.value = double.parse(responseData['count'])
          .toInt(); // Update productCount value
      log(productCount.value.toString());
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
