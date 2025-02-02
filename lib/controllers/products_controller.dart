import 'package:get/get.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

import '../config/common.dart';

class ProductController extends GetxController {
  final String categoryId;
  String searchTerm = ''; // Change RxString to regular String

  ProductController({required this.categoryId, this.searchTerm = ''});

  var products = [].obs;

  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMsg = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<dynamic> fetchProducts() async {
    try {
      isLoading.value = true;
      Map storedUserData = box!.get('userData');
      var responseData = await NetworkRepository.getProducts(
        category: categoryId.toString(),
        status: 'Active',
        search: searchTerm,
        partyId: storedUserData['party']['id'].toString(),
        page: '1',
      );
      List productData = responseData['body']['results'];
      products.assignAll(productData);
    } catch (e) {
      errorMsg.value = e.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}
