import 'dart:developer';

import 'package:get/get.dart';

class CategoryStoreController extends GetxController {
  RxString currentCategory = ''.obs;

  void updateCategory(String category) {
    log('currentCategory.value ${currentCategory.value}');
    currentCategory.value = category;
  }

  String getCategory() {
    log('currentCategory.value ${currentCategory.value}');
    return currentCategory.value;
  }
}
