import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sutra_ecommerce/controllers/popular_controller.dart';
import 'package:sutra_ecommerce/widgets/popular_card/popular_card.dart';

import '../product_grid_screen/produts_grid_screen.dart';

class PopularDealTab extends StatelessWidget {
  final String categoryId;

  // Constructor
  const PopularDealTab({Key? key, required this.categoryId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize the controller inside the build method
    final PopularDealController controller = Get.put(PopularDealController(categoryId: categoryId));

    log(categoryId.toString());

    return Obx(() {
      final popularDeals = controller.popularDeals;

      if (controller.isLoading.value) {
        // If the Future is still running, show a loading indicator
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child:   Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: SizedBox(
            height: 140,
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
        )
        );
      } else if (controller.hasError.value) {
        // If there's an error, display it to the user
        return Center(child: Text('Error: ${controller.errorMsg.value}'));
      }else {

      return Container(
        height: 180,
        color: controller.isLoading.value?Colors.white:Colors.grey.shade300,

        child: ListView.builder(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          itemCount: popularDeals.length ??0,
          itemBuilder: (context, index) {
            return PopularCard(product: popularDeals[index],);
          },
        ),
      );
    }});
  }
}
