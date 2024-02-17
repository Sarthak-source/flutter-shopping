import 'package:get/get.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

class AddAddressController extends GetxController {
  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMsg = ''.obs;
  var myAddressItems = [].obs;
  RxInt slectedIndex =0.obs;

  @override
  void onInit() {
    super.onInit();
    getMyAddress();
  }

  void getMyAddress() async {
    try {
      // Assuming NetworkRepository.getCategories returns a Future<dynamic>
      var responseData = await NetworkRepository.getMyAddress(party: '1');
      List myAddressData = responseData['body']['results'];
      myAddressItems.assignAll(myAddressData);
      update();
      print('myAddressItems++++${myAddressItems.length}');
    } catch (e) {
      errorMsg.value = e.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}