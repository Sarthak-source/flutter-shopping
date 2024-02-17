import 'dart:developer';

import 'package:get/get.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

class AddToCartController extends GetxController {
  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMsg = ''.obs;
  //RxList addToCartList = [].obs;
  RxInt productCount=0.obs;

  void addToCart(count, product, party) async {
    try {
      // Assuming NetworkRepository.getAddToCart returns a Future<dynamic>
      productCount.value++;
      var responseData = await NetworkRepository.addToCart(
          count: count.toString(), product: product.toString(), party: party.toString());
          log('responseData $responseData');
      //List addToCartData = responseData;
      //addToCartList.assignAll(addToCartData);
    } catch (e) {
      log(e.toString());
      errorMsg.value = e.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}
