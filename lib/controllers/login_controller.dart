import 'dart:developer';

import 'package:get/get.dart';
import 'package:sutra_ecommerce/screens/login/verify_otp.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

class LoginController extends GetxController {
  @override
  void onInit(){
    // Get called when controller is created
    super.onInit();
  }
  RxMap user = {}.obs;

   void userExists(String phoneNumberTyped) async {
    // Instantiate LoginController to access instance members
    

    try {
      var value = await networkRepository.checkUser(number: phoneNumberTyped);
      // Accessing user from the instance
      log(value.toString());
      user.value=value;
      update();
      log("user ${user.toString()}");
      

      if (value != null) {
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
