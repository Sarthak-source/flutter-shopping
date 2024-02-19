import 'dart:developer';

import 'package:get/get.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

class AddToCartController extends GetxController {
  @override
  void onInit() {
    // Get called when controller is created
    super.onInit();
  }

  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMsg = ''.obs;
  RxList addToCartList = [].obs;
  RxInt productCount = 0.obs;


  

  void addToCart(count, product, party) async {
    try {
      var responseData = await NetworkRepository.addToCart(
          count: count.toString(),
          product: product.toString(),
          party: party.toString());
      log('responseData $responseData');

      var addToCartData = responseData;
      addToCartList.add(addToCartData);

      productCount.value = double.parse(responseData['count']).toInt() ; // Update productCount value
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
