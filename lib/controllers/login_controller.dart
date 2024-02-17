

    import 'dart:developer';

import 'package:get/get.dart';
import 'package:sutra_ecommerce/screens/login/verify_otp.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

class LoginController extends GetxController {
  
  static userExists(String phoneNumberTyped) async {
      log(phoneNumberTyped);

      // Get.toNamed(
      //     OtpScreen.routeName,
      //     arguments: OtpScreenArguments(phoneNumber: phoneNumberTyped)
      //   );

      try {
        var value = await networkRepository.checkUser(number: phoneNumberTyped);

        log(value.toString());

        if (value != null) {
        var data=  await networkRepository.userLogin(number: phoneNumberTyped);

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