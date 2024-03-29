import 'dart:developer';

import 'package:get/get.dart';
import 'package:sutra_ecommerce/config/common.dart';
import 'package:sutra_ecommerce/controllers/add_to_cart_controller.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

class UserController extends GetxController {
  final AddToCartController addToCardController = Get.put(AddToCartController());

  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMsg = ''.obs;

  var partyConfig={}.obs;
  // Define storedUserData as a local variable inside the class

  // Define user as an observable variable
  var user = {}.obs;

  @override
  void onInit() async {
    // Call super onInit method
    super.onInit();

    // Initialize storedUserData inside onInit method
    // storedUserData = box!.get('userData')??{};

    // // Assign storedUserData to the user variable
    // user.value = storedUserData;
    getUserData();
    getPartyConfig();
  }

  void getUserData() async {
    log('=============================');
    try {
      Map storedUserData = box!.get('userData');
      var responseData = await networkRepository.checkUser(
        number: storedUserData['party']['mobile_NO'],
      );

      log('responseData message  ${responseData.toString()}');
      Map userData = responseData['body'];
      await box!.delete('userData');
      await box!.put('userData', userData);
      user.value = userData;
      update();

      print(
          "productCount in user ctlr ${responseData['body']['party']['party_cart_count'].toString()}");
      print(
          "productCount in user ctlr2 ${userData['party']['party_cart_count'].toString()}");

      addToCardController.productCount.value =
          userData['party']['party_cart_count'].toInt();

      log(responseData['body']);

      log(userData.toString());

      log('=============================');
    } catch (e) {
      errorMsg.value = e.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  getPartyConfig() async {
    log('getPartyConfig');
    try {
      Map storedUserData = box!.get('userData');
      var responseData = await networkRepository.partyConfig(
        storedUserData['party']['id'].toString(),
      );

      log("storedUserData['party']['id'] ${storedUserData['party']['id'].toString()}");

      partyConfig.value= responseData['body'];
    } catch (e) {
      errorMsg.value = e.toString();
      log(e.toString());
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}
