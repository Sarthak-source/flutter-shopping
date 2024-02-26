
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/controllers/popular_deals.dart';
import 'package:sutra_ecommerce/widgets/popular_card/popular_card.dart';

class PopularDealTab extends StatefulWidget {
  const PopularDealTab({super.key});

  @override
  State<PopularDealTab> createState() => _PopularDealTabState();
}

class _PopularDealTabState extends State<PopularDealTab> {
  RxInt quantity =
      0.obs; // Initialize quantity as observable RxInt with value 0

  final PopularDealController controller = Get.put(PopularDealController());



  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final popularDeals = controller.popularDeals;
      return Container(
        height: 175,
        color: Colors.grey.shade300,
        child: ListView.builder(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          itemCount: popularDeals.length,
          itemBuilder: (context, index) {
            return PopularCard(product: popularDeals[index],);
          },
        ),
      );
    });
  }
}
