import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/controllers/popular_deals.dart';
import 'package:sutra_ecommerce/widgets/popular_card/popular_card.dart';

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
      return SizedBox(
        height: 175,
        child: ListView.builder(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          itemCount: popularDeals.length,
          itemBuilder: (context, index) {
            return PopularCard(product: popularDeals[index]);
          },
        ),
      );
    });
  }
}
