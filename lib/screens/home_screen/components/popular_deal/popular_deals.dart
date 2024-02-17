import 'package:flutter/widgets.dart';
import 'package:sutra_ecommerce/utils/screen_utils.dart';
import 'package:sutra_ecommerce/widgets/product_card/product_card.dart';

class PopularDealTab extends StatelessWidget {
  const PopularDealTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: getProportionateScreenWidth(8),
      ),
      delegate: SliverChildListDelegate(
        [
          const ProductCard(
            isLeft: true,
          ),
          const ProductCard(
            isLeft: false,
          ),
        ],
      ),
    );
  }
}