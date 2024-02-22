import 'dart:developer';

import 'package:get/get.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

class PopularDealController extends GetxController {
  PopularDealController();

  var popularDeals = [].obs;

  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMsg = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPopularDeals();
  }

  Future<dynamic> fetchPopularDeals() async {
    try {
      isLoading.value = true;
      var responseData = await NetworkRepository.getProducts(
        category: '',
        status: 'Active',
        search: '',
        partyId: '1',
        page: '1',
      );
      List popularDealData = responseData['body']['results'];
      popularDeals.value=popularDealData;
      log(popularDeals.toString());
    } catch (e) {
      errorMsg.value = e.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}
