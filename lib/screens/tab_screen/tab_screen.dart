import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sutra_ecommerce/controllers/common_controller.dart';
import 'package:sutra_ecommerce/controllers/user_controller.dart';
import 'package:sutra_ecommerce/screens/term_and_conditions/terms_and_conditions.dart';
import 'package:sutra_ecommerce/widgets/go_cart/go_to_cart.dart';
import 'package:sutra_ecommerce/widgets/loading_widgets/loader.dart';

import '../../controllers/catagories_controller.dart';
import '../../controllers/explore_more_poducts_controller.dart';
import '../../controllers/get_deals_controller.dart';
import '../../controllers/popular_controller.dart';
import '../../controllers/product_detail_controller.dart';
import '../../widgets/custom_nav_bar.dart';
import '../cart/cart_screen.dart';
import '../fav_screen/fav_screen.dart';
import '../fav_screen/newFavScreen.dart';
import '../home_screen/home_screen.dart';
import '../myorders_screen.dart';
import '../user_screen/user_screen.dart';

class TabScreen extends StatefulWidget {
  final int? pageIndex;
  static const routeName = '/tabScreen';

  const TabScreen({super.key, this.pageIndex});

  @override
  TabScreenState createState() => TabScreenState();
}

class TabScreenState extends State<TabScreen> {
  int curTab = 0;
  final userController = Get.put(UserController(), permanent: true);

  final dealsController = Get.put(DealsController(), permanent: true);
  final categoriesController = Get.put(CategoriesController(), permanent: true);
  final popularController =
      Get.put(PopularDealController(categoryId: ""), permanent: true);
  final ExploreProductsController expProdController =
      Get.put(ExploreProductsController(categoryId: ''), permanent: true);

  final prodDetailController =
      Get.put(ProductDetailController(), permanent: true);
  final commonController = Get.put(CommonController(), permanent: true);

  final usercontroller = Get.put(UserController());

  //final addToCartController = Get.put(AddToCartController(), permanent: true);

  @override
  void initState() {
    super.initState();

    if (kDebugMode) {
      print('tab screen:::');
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //curTab = commonController.commonCurTab.value;
      //= widget.pageIndex ?? 0;
      //userController.dispose();
      userController.getUserData();
      commonController.update();
      popularController.fetchPopularDeals();
      popularController.update();
      expProdController.fetchExploreProductss();
      expProdController.update();
      dealsController.fetchDealss();
      dealsController.update();
      categoriesController.getCategories();
      categoriesController.update();
    });

    //userController.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const HomeScreen(),
      const newFavScreen(),
      const FavScreen(),
      const CartScreen(),
      //  const PaymentScreen(),
      const MyOrders(),
      UserScreen(),
    ];

    bool routeEnabled = !(usercontroller.partyConfig['party']?['route_code']
            ['is_route_started'] ==
        'NO');

    return WillPopScope(
      onWillPop: () async {
        if (commonController.commonCurTab.value != 0) {
          setState(() {
            commonController.commonCurTab.value = 0;
          });
          return false;
        }
        return true;
      },
      child: Obx(() {
        log("userControllerDataTab ${usercontroller.partyConfig['party']?['route_code']['is_route_started']}");

        return (usercontroller.user['party']?['conditions_accepted']
                    ?.toString() ==
                "YES")
            ? Scaffold(
                bottomSheet:
                    (routeEnabled || commonController.commonCurTab.value == 3)
                        ? null
                        : const GoToCart(usedIn: 'home'),
                body: SafeArea(
                  child: routeEnabled
                      ? Scaffold(
                          body: Center(
                            child: SizedBox(
                              height: 500,
                              child: Column(
                                children: [
                                  const Text(
                                      'The route has not been started yet.'),
                                  Lottie.asset('assets/lotties/routes.json',
                                      repeat: false),
                                ],
                              ),
                            ),
                          ),
                        )
                      : pages[commonController.commonCurTab.value],
                ),
                bottomNavigationBar: routeEnabled
                    ? null
                    : CustomNavBar((index) {
                        commonController.commonCurTab.value = index;
                        commonController.update();
                      }, commonController.commonCurTab.value),
              )
            : usercontroller.partyConfig['link'] != null
                ? TermsOfServiceScreen(
                    url: usercontroller.partyConfig['link'].toString())
                : const Scaffold(
                    body: Loader(),
                  );
      }),
    );
  }
}
