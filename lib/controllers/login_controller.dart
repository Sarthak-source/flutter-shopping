import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/config/common.dart';
import 'package:sutra_ecommerce/controllers/user_controller.dart';
import 'package:sutra_ecommerce/screens/login/verify_otp.dart';
import 'package:sutra_ecommerce/screens/sign_up/sign_message_screen.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

import '../models/stateResponseModel.dart';

class LoginController extends GetxController {
    final UserController userController = Get.put(UserController());

  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMsg = ''.obs;
  var stateList = [].obs;
  stateResponseModel? stateResponse;
  @override
  void onInit() {
    // Get called when controller is created
    super.onInit();
  }

  void userExists(String phoneNumberTyped) async {
    try {
      isLoading.value = true;
      Map<String, dynamic> responseData =
          await networkRepository.checkUser(number: phoneNumberTyped);
      log(responseData.toString());
      box!.delete('userData');

      userController.user.value = responseData['body'];
      await box!.put('userData',  userController.user);
      update();

      if (responseData.isNotEmpty) {
        var data = await networkRepository.userLogin(number: phoneNumberTyped);
        log(data.toString());

        //Get.toNamed(OtpScreen.routeName,arguments: OtpScreenArguments(phoneNumber: phoneNumberTyped));
        Get.offNamed(OtpScreen.routeName,
            arguments: OtpScreenArguments(phoneNumber: phoneNumberTyped));
      }
    } catch (e) {
      errorMsg.value = e.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  void signUp(String name, String mobnum, String state) async {
    try {
      isLoading.value = true;
      Map<String, dynamic> responseData = await networkRepository.userSignup(
          name: name, mobnum: mobnum, state: state);
      log(responseData.toString());

      if (responseData.isNotEmpty) {
        Fluttertoast.showToast(
            msg: "Registered Successfully!", backgroundColor: Colors.green);

        Get.offNamed(SignUpSuccess.routeName);
      }
    } catch (e) {
      errorMsg.value = e.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  Future<stateResponseModel?> getStates() async {
    try {
      isLoading.value = true;
      var responseData = await networkRepository.getStates();
      log(responseData.toString());

      if (responseData != null) {
        //  stateResponse=responseData;
        print('stateResponse::: ${responseData["body"]}');
        stateList.value = responseData["body"] ?? [];
        update();
        //  for(Results item in stateResponse!.results ?? [])
        //    stateList.add(item);

        print('stateList::: ${stateList.length}');
      }
    } catch (e) {
      errorMsg.value = e.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}
