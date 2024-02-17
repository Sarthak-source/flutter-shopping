import 'package:get/get.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

class MyCartController extends GetxController {
  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMsg = ''.obs;
  var mycartItems = [].obs;
  var mycartTotalValue = "".obs;
  var mycartTotalGst = "".obs;
  var mycartTotalAmount = "".obs;

  @override
  void onInit() {
    super.onInit();
    getMyCart();
  }

  void getMyCart() async {
    try {
      // Assuming NetworkRepository.getCategories returns a Future<dynamic>
      var responseData = await NetworkRepository.getMyCart(party: '1');
      List myCartData = responseData['body']['cart_list'];
      dynamic totalValue = responseData['body']['total_value'];
      dynamic totalGst =  responseData['body']['total_gst'];
      dynamic totalAmount = responseData['body']['total_amount'];
      mycartTotalValue =  RxString(totalValue.toString());
      mycartTotalGst = RxString(totalGst.toString());
      mycartTotalAmount =RxString(totalAmount.toString());
      mycartItems.assignAll(myCartData);
      print('mycartItems++++${mycartItems.length}');
    } catch (e) {
      errorMsg.value = e.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}