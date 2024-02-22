import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/controllers/add_to_cart_controller.dart';
import 'package:sutra_ecommerce/widgets/go_cart/go_to_cart.dart';

import '../../widgets/custom_nav_bar.dart';
import '../cart/cart_screen.dart';
import '../fav_screen/fav_screen.dart';
import '../home_screen/home_screen.dart';
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


  @override
  void initState() {
    curTab = widget.pageIndex ?? 0;
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const HomeScreen(),
      const FavScreen(),
      CartScreen(),
      UserScreen(),
    ];

    final AddToCartController addToCartController =
        Get.put(AddToCartController());

    return Obx(() {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: (addToCartController.productCount > 0 && curTab!=2)
            ? const GoToCart()
            : Container(),
        body: SafeArea(
          child: pages[curTab],
        ),
        bottomNavigationBar: CustomNavBar((index) {
          setState(() {
            curTab = index;
          });
        }, curTab),
      );
    });
  }
}
