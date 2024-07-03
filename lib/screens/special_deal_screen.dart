import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sutra_ecommerce/controllers/get_deals_controller.dart';
import 'package:sutra_ecommerce/utils/shimmer_placeholders/myorder_shimmer.dart';

import '../utils/screen_utils.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/deal_card.dart';
import 'product_grid_screen/produts_grid_screen.dart';

class SpecialDealScreen extends StatelessWidget {
  static const routeName = '/special_deal';

  const SpecialDealScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return GetBuilder<DealsController>(
      builder: (controller) {
        if (controller.isLoading.value) {
          return Scaffold(
            body: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: SizedBox(
                height: 140,
                child: ListView.builder(
                  clipBehavior: Clip.none,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.only(right: 12.0),
                      child: MyOrderShimmer(from: "myorder"),
                    );
                  },
                ),
              ),
            ),
          );
        } else if (controller.hasError.value) {
          return Scaffold(
            body: Center(
              child: Text(controller.errorMsg.value),
            ),
          );
        } else {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  CustomAppBar(
                    title: 'Special Deals for You',
                    actions: [
                      // const Icon(
                      //   Icons.search,
                      //   color: kPrimaryBlue,
                      // ),
                      SizedBox(
                        width: getProportionateScreenWidth(16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(32),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(16.0),
                      ),
                      itemCount: controller.deals.length,
                      itemBuilder: (context, index) {
                        final deal = controller.deals[index];
                        log("relovolt deal ${deal.toString()}");
                        return DealCard(
                          onTap: () {
                            Get.toNamed(
                              PoductsListScreen.routeName,
                              arguments: PoductsListArguments(
                                title: controller.deals[index]['heading'],
                                categoryId: controller.deals[index]['category']
                                    .toString(),
                              ),
                            );
                          },
                          isHorizontalScrolling: false,
                          image: deal['deal_img'],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
