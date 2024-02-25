import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/controllers/popular_deals.dart';
import 'package:sutra_ecommerce/utils/common_functions.dart';
import 'package:sutra_ecommerce/utils/screen_utils.dart';

class PopularDealTab extends StatelessWidget {
  final PopularDealController controller = Get.put(PopularDealController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final popularDeals = controller.popularDeals;
      return SizedBox(
        height: 95,
        child: ListView.builder(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          itemCount: popularDeals.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Image.network(
                      popularDeals[index]?['product_img'] ??
                          'http://170.187.232.148/static/images/dilicia.png',
                      fit: BoxFit.fill,
                      height: getProportionateScreenHeight(50),
                    ),
                    Hero(
                      tag: 'productDetailName',
                      child: SizedBox(
                        width: 40,
                        child: Text(
                          titleCase(
                              popularDeals[index]?['name'].toLowerCase() ??
                                  "Not given"),
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w700, fontSize: 13),
                        ),
                      ),
                    ),
                  ],
                ));
          },
        ),
      );
    });
  }
}
