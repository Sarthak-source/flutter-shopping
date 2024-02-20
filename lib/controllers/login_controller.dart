import 'dart:developer';

import 'package:get/get.dart';
import 'package:sutra_ecommerce/screens/login/verify_otp.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

class LoginController extends GetxController {
  @override
  void onInit() {
    // Get called when controller is created
    super.onInit();
  }

  prntUser(){
    log(user.toString());
  }

  final user = {}.obs;

  void userExists(String phoneNumberTyped) async {
    try {
      var responseData =
          await networkRepository.checkUser(number: phoneNumberTyped);
      log(responseData.toString());
      

      if (responseData != null) {
        var data = await networkRepository.userLogin(number: phoneNumberTyped);
        log(data.toString());

        Get.toNamed(OtpScreen.routeName,
            arguments: OtpScreenArguments(phoneNumber: phoneNumberTyped));
            user.value = responseData['body'];
     

      log("user ${user.toString()}");
      }
    } catch (error) {
      log('Error during user check: $error');
      // Handle the error, show a message, or take appropriate action
    }
  }
}
