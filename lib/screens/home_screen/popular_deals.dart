import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/controllers/popular_deals.dart';
import 'package:sutra_ecommerce/widgets/product_card/product_card.dart';

class PopularDealTab extends StatelessWidget {
  final PopularDealController controller = Get.put(PopularDealController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final popularDeals = controller.popularDeals;
      return SliverToBoxAdapter(
        child: SizedBox(
          height: 200, // Fixed height for the horizontal ListView
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: popularDeals.length,
            itemBuilder: (BuildContext context, int index) {
              final deal = popularDeals[index];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: ProductCard(
                  isLeft: index.isEven,
                  product: deal,
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
