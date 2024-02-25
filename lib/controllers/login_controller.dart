import 'dart:developer';

import 'package:get/get.dart';
import 'package:sutra_ecommerce/config/common.dart';
import 'package:sutra_ecommerce/screens/login/verify_otp.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMsg = ''.obs;
  @override
  void onInit() {
    // Get called when controller is created
    super.onInit();
  }

  void userExists(String phoneNumberTyped) async {
    try {
      isLoading.value =true;
      Map<String, dynamic> responseData =
          await networkRepository.checkUser(number: phoneNumberTyped);
      log(responseData.toString());

      await box!.put('login', true);
      await box!.put('userData', responseData['body']);

      Map s = box!.get('userData');
      log("stored ${s.toString()}");

      if (responseData.isNotEmpty) {
        var data = await networkRepository.userLogin(number: phoneNumberTyped);
        log(data.toString());

        //Get.toNamed(OtpScreen.routeName,arguments: OtpScreenArguments(phoneNumber: phoneNumberTyped));
        Get.offNamed(OtpScreen.routeName,arguments: OtpScreenArguments(phoneNumber: phoneNumberTyped));
      }
    } catch (e) {
      errorMsg.value = e.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}
