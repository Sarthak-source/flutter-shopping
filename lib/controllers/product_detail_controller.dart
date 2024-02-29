import 'dart:developer';

import 'package:get/get.dart';
import 'package:sutra_ecommerce/config/common.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

class ProductDetailController extends GetxController {
  String product;

  ProductDetailController({required this.product});

  var productDetail = {}.obs;
  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMsg = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProductDetail();
  }

  Future<void> fetchProductDetail() async {
    try {
      isLoading.value = true;
      Map storedUserData = await box!.get('userData');
      var responseData = await NetworkRepository.getProductDetail(
        partyId: storedUserData['party']['id'].toString(),
        product: product,
      );
      dynamic productData = responseData['body']['results'][0];
      productDetail.value = productData;
      update();

      // Log the received product detail data
      log('Product Detail Data: $productDetail');
    } catch (e) {
      errorMsg.value = e.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}
