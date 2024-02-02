import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../models/category.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/category_card.dart';
import '../../widgets/deal_card.dart';
import '../../widgets/indi_deal_card.dart';
import '../../widgets/tab_title.dart';
import '../category_screen.dart';
import '../popular_deals_screen.dart';
import '../search_screen.dart';
import '../special_deal_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home_screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Category> categories = [
      const Category(
        'Vegetables',
        'assets/images/vegetable_home.png',
        kAccentGreen,
      ),
      const Category(
        'Fruits',
        'assets/images/fruit_home.png',
        kAccentRed,
      ),
      const Category(
        'Milks & Egg',
        'assets/images/egg_home.png',
        kAccentYellow,
      ),
      const Category(
        'Meat',
        'assets/images/meat_home.png',
        kAccentPurple,
      ),
    ];
    ScreenUtils().init(context);

    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: HomeAppBar(),
        ),
       
        const SliverToBoxAdapter(
          child: DealsTab(),
        ),
         SliverToBoxAdapter(
          child: CategoryTab(categories: categories),
        ),
        SliverToBoxAdapter(
          child: TabTitle(
              title: 'Popular Deals',
              seeAll: () {
                Navigator.of(context).pushNamed(PopularDealsScreen.routeName);
              }),
        ),
        const PopularDealTab(),
        // SliverToBoxAdapter(
        //   child: CustomPaint(
        //     size: Size(36, 36),
        //     painter: RPSCustomPainter(),
        //   ),
        // ),
      ],
    );
  }
}

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
          const IndiDealCard(
            isLeft: true,
          ),
          const IndiDealCard(
            isLeft: false,
          ),
        ],
      ),
    );
  }
}

class DealsTab extends StatelessWidget {
  const DealsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabTitle(
            title: 'Special Deals for You',
            seeAll: () {
              Navigator.of(context).pushNamed(SpecialDealScreen.routeName);
            }),
        SizedBox(
          height: getProportionateScreenHeight(10),
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
      ],
    );
  }
}

class CategoryTab extends StatelessWidget {
  const CategoryTab({
    Key? key,
    required this.categories,
  }) : super(key: key);

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(16.0),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Categories',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CategoryScreen.routeName);
                },
                child: const Text(
                  'See All',
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              categories.length,
              (index) => CategoryCard(categories[index]),
            ),
          )
        ],
      ),
    );
  }
}

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(
          16,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Planet Namex 989',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                Text(
                  'Norristown, Pennsyvlvania, 19403',
                  style: TextStyle(
                    color: kTextColorAccent,
                    fontSize: getProportionateScreenWidth(
                      12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(SearchScreen.routeName);
            },
            child: const Icon(
              Icons.search,
              color: kPrimaryBlue,
            ),
          ),
        ],
      ),
    );
  }
}
