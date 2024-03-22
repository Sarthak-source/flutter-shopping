import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/controllers/add_to_cart_controller.dart';
import 'package:sutra_ecommerce/controllers/common_controller.dart';
import 'package:sutra_ecommerce/widgets/go_cart/go_to_cart.dart';

import '../../controllers/catagories_controller.dart';
import '../../controllers/get_deals_controller.dart';
import '../../controllers/popular_controller.dart';
import '../../controllers/product_detail_controller.dart';
import '../../widgets/custom_nav_bar.dart';
import '../cart/cart_screen.dart';
import '../fav_screen/fav_screen.dart';
import '../home_screen/home_screen.dart';
import '../myorders_screen.dart';
import '../paymentScreen/paymentScreen.dart';
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
  final dealsController = Get.put(DealsController(), permanent: true);
  final categoriesController = Get.put(CategoriesController(), permanent: true);
  final popularController = Get.put(PopularDealController(categoryId: ""), permanent: true);
  final prodDetailController = Get.put(ProductDetailController(), permanent: true);
  final commonController = Get.put(CommonController(), permanent: true);
  //final userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
   // curTab = widget.pageIndex ?? 0;

    print('tab screen:::');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      commonController.commonCurTab.value = widget.pageIndex ?? 0;
      commonController.update();
      popularController.fetchPopularDeals();
      popularController.update();
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
      const FavScreen(),
      CartScreen(),
    //  const PaymentScreen(),
       MyOrders(),
      UserScreen(),
    ];

    final AddToCartController addToCartController =
        Get.put(AddToCartController());

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
        return Scaffold(
          bottomSheet: (addToCartController.productCount > 0 && commonController.commonCurTab.value != 2)
              ? const GoToCart(
                  usedIn: 'home',
                )
              : const SizedBox.shrink(),
          body: SafeArea(
            child: pages[commonController.commonCurTab.value],
          ),
          bottomNavigationBar: CustomNavBar((index) {
           // setState(() {
              commonController.commonCurTab.value = index;
              commonController.update();

           // });
          },
              commonController.commonCurTab.value),
        );
      }),
    );
  }
}
