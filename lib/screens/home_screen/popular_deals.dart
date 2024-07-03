import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sutra_ecommerce/controllers/popular_controller.dart';
import 'package:sutra_ecommerce/utils/error.dart';
import 'package:sutra_ecommerce/widgets/popular_card/popular_card.dart';

import '../../constants/colors.dart';
import '../../controllers/add_to_cart_controller.dart';
import '../product_grid_screen/produts_grid_screen.dart';

class PopularDealTab extends StatefulWidget {
  final String categoryId;
  final String? isfrom;

  const PopularDealTab({super.key, required this.categoryId, this.isfrom});

  @override
  State<PopularDealTab> createState() => _PopularDealTabState();
}

class _PopularDealTabState extends State<PopularDealTab> {
  int _selectedIndex = -1;

  final AddToCartController addToCartController =
      Get.put(AddToCartController());

  @override
  Widget build(BuildContext context) {
    // Initialize the controller inside the build method
    final PopularDealController controller =
        Get.put(PopularDealController(categoryId: widget.categoryId));

    log(widget.categoryId.toString());

    return Obx(() {
      final popularDeals = controller.popularDeals;
      controller.update();
      print('populardeals::${popularDeals.length}');
      if (popularDeals.isEmpty) {
        // If the Future is still running, show a loading indicator
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: SizedBox(
                height: Get.height / 4.5,
                child: ListView.builder(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  itemCount: 5, // Use a placeholder count
                  itemBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.only(left: 12, bottom: 8),
                      child: ProductCardPlaceholder(isFrom: "homepop"),
                    );
                  },
                ),
              ),
            ));
      } else if (controller.hasError.value) {
        // If there's an error, display it to the user
        return const ErrorHandleWidget();
      } else {
        return Column(
          children: [
            Container(
              height: Get.width >= 600 ? 265 : 205,
              //  color: popularDeals.isEmpty ? Colors.white : Colors.grey.shade300,
              color: popularDeals.isEmpty ? Colors.white : kPrimaryBlueTest,
              child: popularDeals == null || popularDeals.isEmpty
                  ? const SizedBox.shrink()
                  : ListView.builder(
                      clipBehavior: Clip.none,
                      scrollDirection: Axis.horizontal,
                      itemCount: popularDeals.length ?? 0,
                      itemBuilder: (context, index) {
                        return PopularCard(
                          onCardAddClicked: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                          onCardMinusClicked: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                          onAddClicked: () {
                            /*    setState(() {
                        _selectedIndex = index;
                      });*/
                          },
                          product: popularDeals[index],
                          isFrom: widget.isfrom,
                          loader: index == _selectedIndex
                              ? addToCartController.isLoading.value
                              : false,
                        );
                      },
                    ),
            ),
          ],
        );
      }
    });
  }
}
