import 'dart:developer';

import 'package:get/get.dart';
import 'package:sutra_ecommerce/config/common.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

class UserController extends GetxController {
  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMsg = ''.obs;

  // Define storedUserData as a local variable inside the class
  late Map storedUserData;

  // Define user as an observable variable
  var user = {}.obs;

  @override
  void onInit() {
    // Call super onInit method
    super.onInit();

    // Initialize storedUserData inside onInit method
    storedUserData = box!.get('userData')??{};

    // Assign storedUserData to the user variable
    user.value = storedUserData;
    getUserData();
  }

  void getUserData() async {
    try {
      var responseData = await networkRepository.checkUser(
        number: storedUserData['party']['phone'],
      );

      log('responseData message  ${responseData.toString()}');
      Map userData = responseData['body'] ?? storedUserData;

      log(responseData['body']);


      await box!.put('userData', responseData['body']);
      log(userData.toString());
      user.value = userData;
      update();
    } catch (e) {
      errorMsg.value = e.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}
