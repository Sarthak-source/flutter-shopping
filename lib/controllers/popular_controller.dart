import 'dart:developer';

import 'package:get/get.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

import '../config/common.dart';

class PopularDealController extends GetxController {
  final String categoryId;
  PopularDealController({required this.categoryId,});

  var popularDeals = [].obs;
  RxInt quantity = 0.obs;
  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMsg = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPopularDeals();
  }
  @override
  void onReady() {
   // fetchPopularDeals();
    super.onReady();
  }

  Future<dynamic> fetchPopularDeals() async {
    try {
      Map storedUserData=box!.get('userData');

      log(categoryId.toString());

      isLoading.value = true;
      var responseData = await NetworkRepository.getProducts(
        category: categoryId.toString(),
        status: 'Active',
        search: '',
        partyId: storedUserData['party']['id'].toString(),
        page: '1',
      );
      List popularDealData = responseData['body']['results'];
      log(popularDealData.toString());
      if(popularDealData != null){
        popularDeals.assignAll(popularDealData);
        update();
      }

      log(popularDeals.toString());
    } catch (e) {
      errorMsg.value = e.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}
