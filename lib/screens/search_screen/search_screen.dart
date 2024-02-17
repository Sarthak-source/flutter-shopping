import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/screen_utils.dart';
import '../../widgets/custom_nav_bar.dart';
import '../../widgets/deal_card.dart';
import '../../widgets/product_card/product_card.dart';
import '../../widgets/search_bar.dart' as search;
import '../../widgets/tab_title.dart';
import '../fruit_screen.dart';
import '../vegetable_screen.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = '/search_screen';

  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SearchTab(),
              SizedBox(
                height: getProportionateScreenHeight(32),
              ),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    DealCard(),
                    DealCard(),
                  ],
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(16),
              ),
              TabTitle(
                title: 'Featured Vegetables',
                seeAll: () {
                  Get.toNamed(VegetableScreen.routeName);
                },
              ),
              SizedBox(
                height: getProportionateScreenHeight(240),
                child: Row(
                  children: [
                    const Expanded(
                      child: ProductCard(
                        isLeft: true,
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(8.0),
                    ),
                    const Expanded(
                      child: ProductCard(
                        isLeft: false,
                      ),
                    ),
                  ],
                ),
              ),
              TabTitle(
                title: 'Special Bundle',
                seeAll: () {},
              ),
              SizedBox(
                height: getProportionateScreenHeight(240),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(FruitScreen.routeName);
                        },
                        child: const ProductCard(
                          isLeft: true,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(8.0),
                    ),
                    const Expanded(
                      child: ProductCard(
                        isLeft: false,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavBar((_) {}, 0),
    );
  }
}

class SearchTab extends StatelessWidget {
  const SearchTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(16.0),
      ),
      child: Row(
        children: [
          const Expanded(
            child: search.SearchBar('Search for Anything'),
          ),
          SizedBox(
            width: getProportionateScreenWidth(10),
          ),
          Image.asset('assets/images/bell.png'),
        ],
      ),
    );
  }
}