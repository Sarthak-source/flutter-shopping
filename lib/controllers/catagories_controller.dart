import 'package:get/get.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

class CategoriesController extends GetxController {
  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMsg = ''.obs;
  var categories = [].obs;

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  void getCategories() async {
    try {
      // Assuming NetworkRepository.getCategories returns a Future<dynamic>
      var responseData = await NetworkRepository.getCategories(
        level: '2',
        parent: '',
      );
      List categoriesData = responseData['body']['results'];
      categories.assignAll(categoriesData);
    } catch (e) {
      errorMsg.value = e.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}