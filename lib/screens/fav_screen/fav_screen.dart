import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../models/item.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/indi_deal_card.dart';
import '../../widgets/list_card.dart';
import '../../widgets/tab_title.dart';

class FavScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> emptyCartWidgets = [
      Row(
        children: [
          Text(
            'My Favorite',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const Spacer(),
          const Icon(
            Icons.search,
            color: kPrimaryBlue,
          ),
        ],
      ),
      SizedBox(
        height: getProportionateScreenHeight(16.0),
      ),
      Lottie.asset('assets/lotties/cart.json',
          repeat: false,
          height: getProportionateScreenHeight(250.0),
          width: getProportionateScreenWidth(250.0)),
      SizedBox(
        height: getProportionateScreenHeight(10.0),
      ),
      Text(
        'Oops your wishlish is empty',
        style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
      ),
      SizedBox(
        height: getProportionateScreenHeight(16.0),
      ),
      Text(
        'It seems notinh in here. Explore more and shortlist some items',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: kTextColorAccent,
            ),
      ),
      SizedBox(
        height: getProportionateScreenHeight(16.0),
      ),
      ElevatedButton(
        onPressed: () {},
        child: const Text(
          'Start Shopping',
        ),
      ),
      SizedBox(
        height: getProportionateScreenHeight(16.0),
      ),
      const TabTitle(
        title: 'Recommendation for you',
        padding: 0,
      ),
      SizedBox(
        height: getProportionateScreenHeight(220),
        child: Row(
          children: [
            const Expanded(
              child: IndiDealCard(
                noPadding: true,
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(8),
            ),
            const Expanded(
              child: IndiDealCard(
                noPadding: true,
              ),
            ),
          ],
        ),
      ),
    ];

    List<Widget> cartWidgets = List.generate(
      Provider.of<Items>(context, listen: false).favoriteItems.length,
      (index) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ListCard(
            isDiscount: true,
            isSelected: false,
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: getProportionateScreenHeight(40.0),
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Remove'),
                  ),
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(16.0),
              ),
              Expanded(
                child: SizedBox(
                  height: getProportionateScreenHeight(40.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Add to Cart'),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(16.0),
          ),
        ],
      ),
    );
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(16.0),
      ),
      child: SingleChildScrollView(
        child: Column(
            children: Provider.of<Items>(context).favoriteItems.isEmpty
                ? emptyCartWidgets
                : cartWidgets),
      ),
    );
  }
}
