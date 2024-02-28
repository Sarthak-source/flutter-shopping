import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:sutra_ecommerce/screens/add_address/add_address_screen.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

import '../config/common.dart';
import '../screens/add_address/post_address.dart';
import '../utils/generic_exception.dart';

class AddAddressController extends GetxController {
  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMsg = ''.obs;
  var myAddressItems = [].obs;
  RxString? NewAddres= ''.obs;
  RxInt slectedIndex =0.obs;

  @override
  void onInit() {
    super.onInit();
    getMyAddress();
  }

  void getMyAddress() async {
    try {
      // Assuming NetworkRepository.getCategories returns a Future<dynamic>
      Map storedUserData=box!.get('userData');

      var responseData = await NetworkRepository.getMyAddress(party:storedUserData['party']['id'].toString());
          //party:"100");

      List myAddressData = responseData['body']['results'];
      myAddressItems.assignAll(myAddressData);
      update();
      log('myAddressItems++++${myAddressItems.length}');
    } on AppException catch (appException) {
      errorMsg.value = appException.statusCode.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  void addNewAddress(String add1,String add2,String add3,String pincode,String gst) async {
    try {
      isLoading.value = true;
      var responseData = await NetworkRepository.addNewAddress(
          add1: add1.toString(),
          add2: add2.toString(),
          add3: add3.toString(),
          pincode: pincode.toString(),
          gst: gst.toString());

      log('addNewAddress responseData $responseData');
      String jsonString = jsonEncode(responseData['body']);
      Map<String, dynamic> data = jsonDecode(jsonString);


      String? addNewAddress = data['address_line1'];
      log("address from myorderdetail $addNewAddress");
      if(addNewAddress != null && addNewAddress != ""){
        getMyAddress();
        NewAddres?.value = data['address_line1'];


      }

      var addToCartData = responseData;
      update(); // Notify observers about the change
    } catch (e) {
      log(e.toString());
      errorMsg.value = e.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}