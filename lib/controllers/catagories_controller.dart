import 'package:get/get.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

class CategoriesController extends GetxController {
  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMsg = ''.obs;
  var categories = [].obs;
  var Subcategories = [].obs;
  var Subcategories2 = [].obs;

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }
  @override
  void onReady() {
    print('ControllerTwo onReady');
    getCategories();
    super.onReady();
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
      update();
    } catch (e) {
      errorMsg.value = e.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  void getSubCategories(String subCatId,String type) async {
    try {
      isLoading.value =true;
      // Assuming NetworkRepository.getCategories returns a Future<dynamic>
      var responseData = await NetworkRepository.getSubCategories(subcatId: subCatId,
      );
      List categoriesData = responseData['body']['results'];
      if(type =="1"){
        Subcategories.clear;
        Subcategories.assignAll(categoriesData);
      }else if(type == "2"){
        Subcategories.clear;
        Subcategories2.assignAll(categoriesData);
      }


      update();
    } catch (e) {
      errorMsg.value = e.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}