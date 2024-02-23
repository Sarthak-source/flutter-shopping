import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/controllers/popular_deals.dart';
import 'package:sutra_ecommerce/screens/product_grid_screen/produts_grid_screen.dart';
import 'package:sutra_ecommerce/utils/screen_utils.dart';
import 'package:sutra_ecommerce/widgets/product_card/product_card.dart';

class PopularDealTab extends StatelessWidget {
  final PopularDealController controller = Get.put(PopularDealController());
  PopularDealTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () {
        final popularDeals = controller.popularDeals;
        if (popularDeals.isEmpty) {
          return SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: (Get.width / Get.height) * 1.75,
              crossAxisSpacing: getProportionateScreenWidth(14),
              mainAxisSpacing: getProportionateScreenHeight(8),
            ),
            delegate: SliverChildListDelegate(
              List.generate(
                10,
                    (index) {
                  log("popularDeals ${popularDeals.toString()}");
                  if (index % 2 != 0) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const ProductCardPlaceholder(),
                    );
                  } else if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const ProductCardPlaceholder(),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const ProductCardPlaceholder(),
                  );
                },
              ),
            ),
          );
        } else {
          return SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: (Get.width / Get.height) * 1.75,
              crossAxisSpacing: getProportionateScreenWidth(14),
              mainAxisSpacing: getProportionateScreenHeight(8),
            ),
            delegate: SliverChildListDelegate(
              List.generate(
                controller.popularDeals.length,
                    (index) {
                  log("popularDeals ${popularDeals.toString()}");
                  if (index % 2 != 0) {
                    return ProductCard(
                      isLeft: false,
                      product: popularDeals[index],
                    );
                  } else if (index == 0) {
                    return ProductCard(
                      isLeft: true,
                      //addHandler: addCallback,
                      product: popularDeals[index],
                    );
                  }
                  return ProductCard(
                    isLeft: true,
                    product: popularDeals[index],
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}