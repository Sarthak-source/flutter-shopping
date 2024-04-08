import 'dart:developer';

import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
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
  var version =''.obs;
  var localVersion =0.obs;
  var isUpdate = false.obs;
  num buildNumber = 0;
  num localBuildNumber = 0;
  var buildversion = 0.obs;

  PackageInfo? packageInfo;
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
      log('getUserData mobile  ${storedUserData['party']['mobile_NO'].toString()}');
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
      packageInfo = await PackageInfo.fromPlatform();
      log("storedUserData['party']['id'] ${storedUserData['party']['id'].toString()}");


      partyConfig.value= responseData['body'];

         await box!.delete('partyConfigData');
       await box!.put('partyConfigData',  partyConfig);
      Map getPartyConfig = box!.get('partyConfigData');
      //print("app version in user user ctrlr ${getPartyConfig['update']['app_version'].toString()}");

      if(getPartyConfig['update'] != null && getPartyConfig['update']['app_version'] != null){
        version.value = getPartyConfig['update']['app_version'].toString();
        String buildNumberString = version.value!.split('+')[1];
        buildNumber = num.tryParse(buildNumberString) ?? 0;
        print('App buildNumber : ${buildNumber.toString()}');
        buildversion.value = buildNumber.toInt();
        localBuildNumber =num.parse(packageInfo?.buildNumber.toString() ?? "");
        localVersion.value = localBuildNumber.toInt();
        print('localVersion : ${localVersion.value.toString()}');
        if(localVersion.value < buildversion.value){
          isUpdate.value = true;
          update();
        }
      }

    } catch (e) {
      errorMsg.value = e.toString();
      log(e.toString());
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}
