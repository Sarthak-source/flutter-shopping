import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/constants/colors.dart';
import 'package:sutra_ecommerce/controllers/add_to_cart_controller.dart';
import 'package:sutra_ecommerce/controllers/popular_deals.dart';
import 'package:sutra_ecommerce/utils/common_functions.dart';
import 'package:sutra_ecommerce/utils/screen_utils.dart';

class PopularDealTab extends StatefulWidget {
  @override
  State<PopularDealTab> createState() => _PopularDealTabState();
}

class _PopularDealTabState extends State<PopularDealTab> {
  RxInt quantity =
      0.obs; // Initialize quantity as observable RxInt with value 0

  @override
  final PopularDealController controller = Get.put(PopularDealController());

  final AddToCartController addToCartController =
      Get.put(AddToCartController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final popularDeals = controller.popularDeals;
      return SizedBox(
        height: 175,
        child: ListView.builder(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          itemCount: popularDeals.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: 170,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 1.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(
                      getProportionateScreenWidth(
                        8,
                      ),
                    ),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: kShadowColor,
                    //     offset: Offset(
                    //       getProportionateScreenWidth(3),
                    //       getProportionateScreenWidth(3),
                    //     ),
                    //     blurRadius: 1,
                    //   )
                    // ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.network(
                          popularDeals[index]?['product_img'] ??
                              'http://170.187.232.148/static/images/dilicia.png',
                          fit: BoxFit.fill,
                          height: getProportionateScreenHeight(60),
                        ),
                        const Spacer(),
                        Hero(
                          tag: 'productDetailName',
                          child: SizedBox(
                            width: 150,
                            child: Text(
                              titleCase(
                                  popularDeals[index]?['name'].toLowerCase() ??
                                      "Not given"),
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              "${convertDoubleToString(popularDeals[index]?['packing_qty'].toString() ?? '0.0')} ${popularDeals[index]?['packing_uom']}",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(12),
                                color: kTextColorAccent,
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "₹ ${convertDoubleToString(popularDeals[index]?['price'].toString() ?? '0.0 ')}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                            Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color:
                                      kPrimaryBlue, // Set your desired border color
                                  width: 1.0, // Set the border width
                                ),
                                borderRadius: BorderRadius.circular(
                                    10.0), // Set the border radius
                              ),
                              child: SizedBox(
                                height: 35,
                                width: quantity.value == 0
                                    ? 76
                                    : (quantity.toString().length * 11) + 75,
                                child: quantity.value == 0
                                    ? OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          side: const BorderSide(
                                              color: kPrimaryBlue),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10.0), // Set your desired border radius
                                          ),
                                        ),
                                        onPressed: () async {
                                          log('20');
                                          quantity.value++;
                                          addToCartController.productCount++;
                                          addToCartController.addToCart(
                                              quantity.value,
                                              popularDeals[index]?['id'],
                                              '1');

                                          addToCartController.update();
                                        },
                                        child: Text(
                                          'Add',
                                          style: TextStyle(
                                              color: kPrimaryBlue,
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      14)),
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Transform.translate(
                                            offset: const Offset(-12, 0),
                                            child: SizedBox(
                                              width: 12,
                                              child: IconButton(
                                                padding: EdgeInsets.zero,
                                                icon: const Icon(
                                                  Icons.remove,
                                                  color: kPrimaryBlue,
                                                  size: 20,
                                                ),
                                                onPressed: () {
                                                  quantity.value--;
                                                  addToCartController
                                                      .productCount--;
                                                  addToCartController.addToCart(
                                                      quantity.value,
                                                      popularDeals[index]
                                                          ?['id'],
                                                      '1');

                                                  addToCartController.update();
                                                },
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 35,
                                            width: (quantity.value
                                                        .toString()
                                                        .length *
                                                    11) +
                                                20,
                                            color: kPrimaryBlue,
                                            child: Center(
                                              child: Text(
                                                quantity.value.toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          Transform.translate(
                                            offset: const Offset(3.5, 0),
                                            child: SizedBox(
                                              width: 12,
                                              child: IconButton(
                                                padding: EdgeInsets.zero,
                                                icon: const Icon(
                                                  Icons.add,
                                                  color: kPrimaryBlue,
                                                  size: 20,
                                                ),
                                                onPressed: () {
                                                  quantity.value++;
                                                  addToCartController.addToCart(
                                                      quantity.value,
                                                      popularDeals[index]
                                                          ?['id'],
                                                      '1');

                                                  addToCartController
                                                      .productCount++;
                                                  addToCartController.update();
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ));
          },
        ),
      );
    });
  }
}
