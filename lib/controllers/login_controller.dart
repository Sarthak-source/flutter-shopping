import 'dart:developer';

import 'package:get/get.dart';
import 'package:sutra_ecommerce/config/common.dart';
import 'package:sutra_ecommerce/screens/login/verify_otp.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

class LoginController extends GetxController {
  @override
  void onInit() {
    // Get called when controller is created
    super.onInit();
  }

  void userExists(String phoneNumberTyped) async {
    try {
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

        Get.toNamed(OtpScreen.routeName,
            arguments: OtpScreenArguments(phoneNumber: phoneNumberTyped));
      }
    } catch (error) {
      log('Error during user check: $error');
      // Handle the error, show a message, or take appropriate action
    }
  }
}
