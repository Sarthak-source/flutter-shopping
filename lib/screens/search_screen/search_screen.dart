import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/constants/colors.dart';
import 'package:sutra_ecommerce/controllers/add_to_cart_controller.dart';
import 'package:sutra_ecommerce/screens/product_grid_screen/produts_grid_screen.dart';
import 'package:sutra_ecommerce/widgets/go_cart/go_to_cart.dart';

import '../../utils/screen_utils.dart';
import '../../widgets/search_bar.dart' as search;

class SearchScreen extends StatelessWidget {
  static const routeName = '/search_screen';

  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

      final AddToCartController addToCartController =
        Get.put(AddToCartController());
    return Obx( ()=>
      Scaffold(

        bottomSheet: (addToCartController.productCount > 0 )
              ? const GoToCart(usedIn: "PoductsListScreen",)
              : const SizedBox.shrink(),
        body: SafeArea(
          child:Column(
            children: [
              Hero(
                tag: 'search',
                child: Material(
                  child: SearchTab(
                    key: const Key('value'),
                    textEditingController: searchController,
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(32),
              ),
              Expanded(
                child: CustomStaggerGrid(
                addCallback: () {},
              ),
              ),
              SizedBox(height: 20,)
            ],
          )
          
  /*        Stack(
            children: [
              Hero(
                tag: 'search',
                child: Material(
                  child: SearchTab(
                    key: const Key('value'),
                    textEditingController: searchController,
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(32),
              ),
              Transform.translate(
                offset: const Offset(0, 75),
                child: SizedBox(
                  height: Get.height,
                  child: CustomStaggerGrid(
                    addCallback: () {},
                  ),
                ),
              ),
              SizedBox(height: 500,)
            ],
          ),*/
        ),

        //bottomNavigationBar: CustomNavBar((_) {}, 0),
      ),
    );
  }
}

class SearchTab extends StatelessWidget {
  const SearchTab({
    Key? key,
    required this.textEditingController,
  }) : super(key: key);

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(16.0),
      ),
      child: Row(
        children: [
          InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                CupertinoIcons.back,
                size: 35,
                color: kPrimaryBlue,
              )),

          const Expanded(
            child: search.SearchBar(hint: 'Search for products'),
          ),
          SizedBox(
            width: getProportionateScreenWidth(10),
          ),
          //Image.asset('assets/images/bell.png'),
        ],
      ),
    );
  }
}
