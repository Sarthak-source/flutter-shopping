import 'dart:developer';

import 'package:get/get.dart';
import 'package:sutra_ecommerce/controllers/get_deals_controller.dart';
import 'package:sutra_ecommerce/controllers/mycart_controller.dart';
import 'package:sutra_ecommerce/controllers/popular_controller.dart';
import 'package:sutra_ecommerce/controllers/product_detail_controller.dart';
import 'package:sutra_ecommerce/controllers/user_controller.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

import '../config/common.dart';
import 'catagories_controller.dart';
import 'explore_more_poducts_controller.dart';

class AddToCartController extends GetxController {
  //final UserController userController = Get.put(UserController());
  final MyCartController cartController = Get.put(MyCartController());
  final PopularDealController popController = Get.put(PopularDealController(categoryId: ''));
  final ExploreProductsController expProdController = Get.put(ExploreProductsController(categoryId: ''));
  final ProductDetailController prodDetailController = Get.put(ProductDetailController());

  RxInt productCount = 0.obs;
  @override
  void onInit() {
    // Get called when controller is created
    // productCount.value =
    //     userController.user['party']['party_cart_count'].toInt();

    // log("productCount ${productCount.value.toString()}");
    super.onInit();
  }

  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMsg = ''.obs;
  var myUpdatecartItems = [].obs;

  RxList addToCartList = [].obs;
  //int intialProductCount=userController.user[''];

  void updateCartData(List newCartItems, responseData) {
    print('cartitems inside update fun :${newCartItems.length}');

    cartController.updateCart(newCartItems,
        responseData); // Call the method in CartController to update cart data
    if (newCartItems.length == 0) {
      print('newcart length zero${newCartItems.length}');
      productCount.value = 0;
    }
    for (var i = 0; i <= newCartItems.length; i++) {
      print('newCartItems count ${newCartItems[i]['party_cart_count']}');

      productCount.value = newCartItems[i]['party_cart_count'].toInt();
    }
  }

  void addToCart(count, product, party, productBody) async {
    log(product.toString());
    try {
      Map storedUserData = box!.get('userData');
      isLoading.value = true;
      log("addToCart $count $product");
      var responseData = await NetworkRepository.addToCart(
          count: count.toString(),
          product: product.toString(),
          party: storedUserData['party']['id'].toString());
      log('responseData $responseData');

      var addToCartData = responseData;
      //addToCartList.add(addToCartData);

      productCount.value = addToCartData['party_cart_count']?.toInt() ?? 0;

      // Update productCount value
      //log("productCountFullvalu $addToCartData $count");
      update(); // Notify observers about the change
      cartController.getMyCart();
      cartController.update();
      popController.fetchPopularDeals();
      popController.update();
      expProdController.fetchExploreProductss();
      expProdController.update();
      prodDetailController.fetchProductDetail(product.toString());
      prodDetailController.update();
      if (responseData != null) {
        isLoading.value = false;
      }

      //productCount.value = double.parse((productCount.value/2).toString()).toInt() + double.parse(count).toInt();
    } catch (e) {
      log(e.toString());
      errorMsg.value = e.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
      update();
    }
  }

  void updateCart(count, cart, type, party) async {
    try {
      Map storedUserData = box!.get('userData');
      var responseData = await NetworkRepository.UpdateCart(
          count: count.toString(),
          cart: cart.toString(),
          type: type.toString(),
          party: storedUserData['party']['id'].toString());
      log('responseData $responseData');

      //var addToCartData = responseData;
      List myCartData = responseData['body']['cart_list'];
      myUpdatecartItems.addAll(myCartData);
      update();

      print('myUpdatecartItems==>> ${myUpdatecartItems.length}');
      updateCartData(myCartData, responseData);
      //  cartController.mycartItems.add(addToCartData);
      cartController.update();
      popController.fetchPopularDeals();
      popController.update();
      expProdController.fetchExploreProductss();
      expProdController.update();
      // mycartItems.add(addToCartData);
    } catch (e) {
      log(e.toString());
      errorMsg.value = e.toString();
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}

class StoreBinding implements Bindings {
// default dependency
  StoreBinding();
  @override
  void dependencies() {
    Get.put(() => UserController());
    //  Get.lazyPut(() => ProfileController(), tag: tag);
    Get.put(() => MyCartController());
    Get.put(() => AddToCartController());
    Get.put(() => PopularDealController(categoryId: ''));
    Get.put(() => DealsController());
    Get.put(() => CategoriesController());
    Get.put(() => ProductDetailController());
    
  }
}

Future<void> init() async {
  Get.put(() => UserController());
  Get.put(() => MyCartController());
  Get.put(() => AddToCartController());
  Get.put(() => PopularDealController(categoryId: ''));
  Get.put(() => DealsController());
  Get.put(() => CategoriesController());
}
