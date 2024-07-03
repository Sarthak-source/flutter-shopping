import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:sutra_ecommerce/config/common.dart';
import 'package:sutra_ecommerce/controllers/user_controller.dart';
import 'package:sutra_ecommerce/screens/login/verify_otp.dart';
import 'package:sutra_ecommerce/screens/sign_up/sign_message_screen.dart';
import 'package:sutra_ecommerce/screens/sign_up/sign_wait_screen.dart';
import 'package:sutra_ecommerce/screens/tab_screen/tab_screen.dart';
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
      if (!box!.isOpen) {
        box = await Hive.openBox('Box');
      }
      isLoading.value = true;
      Map<String, dynamic> responseData =
          await networkRepository.checkUser(number: phoneNumberTyped);
      log(responseData.toString());
      // box!.delete('userData');

      userController.user.value = responseData['body'];

      log('userController.user ${userController.user}');
      await box!.put('userData', userController.user);
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
        if (responseData.containsKey('mobile_NO') &&
            responseData['mobile_NO'][0] ==
                'new party contact with this mobile NO already exists.') {
          Fluttertoast.showToast(
              msg: responseData['mobile_NO'][0].toString(),
              backgroundColor: Colors.red);

          Get.offNamed(SignUpWait.routeName);
        } else {
          Fluttertoast.showToast(
              msg: "Registered Successfully!", backgroundColor: Colors.green);

          Get.offNamed(SignUpSuccess.routeName);
        }
      }
    } catch (e) {
      log(e.toString());
      String errorMessage;

      if (e is Map<String, dynamic> && e.containsKey('body')) {
        errorMessage = e['body'].toString();
      } else {
        errorMessage = e.toString();
      }

      errorMsg.value = errorMessage;
      //Get.offNamed(SignUpWait.routeName);
      //Fluttertoast.showToast(msg: errorMessage, backgroundColor: Colors.red);
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

  verifyOtpCode(
      OtpScreenArguments args,
      TextEditingController otpController,
      BuildContext context,
      String? name,
      String? phone,
      String? state,
      String? usedIn) async {
    FocusScope.of(context).requestFocus(FocusNode());

    isLoading.value = false;

    if (otpController.text.isNotEmpty) {
      try {
        //  Get.toNamed(TabScreen.routeName);

        //Get.offNamed(TabScreen.routeName);

        log('cybercripe ${args.phoneNumber} ${otpController.text}');

        var value = await networkRepository.verifyLogin(
          number: args.phoneNumber,
          otp: otpController.text,
        );

        //log(value.toString());

        if (value["type"].toString() == "error") {
          Fluttertoast.showToast(msg: 'wrong OTP');
          otpController.clear();
        } else {
          Future.delayed(Duration.zero, () async {
            try {
              //await sendFCMAndLocation();
            } catch (e) {
              Fluttertoast.showToast(msg: e.toString());
            }
          });

          //box!.put("login", true);
          if (!context.mounted) return;

          if (usedIn == 'signUp') {
            signUp(name!, phone!, state!);
          } else {
            await box!.put('login', true);
            Get.offNamed(TabScreen.routeName);
          }
        }
      } catch (error) {
        Fluttertoast.showToast(msg: 'Error verifying OTP');
      }
    } else {
      Fluttertoast.showToast(msg: 'Enter OTP');
    }
  }
}
