import 'dart:developer';

import 'package:get/get.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

import '../config/common.dart';

class ExploreMoreController extends GetxController {
  
  ExploreMoreController();

  var exploreMores = [].obs;

  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMsg = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchExploreMores();
  }

  @override
  void onReady() {
    // fetchExploreMores();
    super.onReady();
  }

  Future<dynamic> fetchExploreMores() async {
    try {
      Map storedUserData = box!.get('userData');
      
      isLoading.value = true;
      var responseData = await NetworkRepository.getExploreMore(
        level: '2',
        party: storedUserData['party']['id'].toString(),
      );

      log(responseData.toString());

      List exploreMoreData = responseData['body']['results'];
      exploreMores.value = exploreMoreData;
      update();
      log(exploreMores.toString());
    } catch (e) {
      errorMsg.value = e.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}
