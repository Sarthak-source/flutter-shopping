import 'package:get/get.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

import '../config/common.dart';

class ExploreProductsController extends GetxController {
  final String categoryId;
  String searchTerm = ''; // Change RxString to regular String

  ExploreProductsController({required this.categoryId, this.searchTerm = ''});

  var exploreProducts = [].obs;

  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMsg = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchExploreProductss();
  }

  Future<dynamic> fetchExploreProductss() async {
    try {
      isLoading.value = true;
      Map storedUserData=box!.get('userData');
      var responseData = await NetworkRepository.getExploreProducts(
        category: categoryId.toString(),
        status: 'Active',
        search: searchTerm,
        partyId: storedUserData['party']['id'].toString(),
        page: '1',
      );
      List exploreProductsData = responseData['body']['results'];
      exploreProducts.assignAll(exploreProductsData);
    } catch (e) {
      errorMsg.value = e.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}
