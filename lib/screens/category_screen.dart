import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../models/category.dart';
import '../utils/screen_utils.dart';
import '../widgets/category_card.dart';
import '../widgets/custom_app_bar.dart';

class CategoryScreen extends StatelessWidget {
  static const routeName = '/category_screen';

  const CategoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final List<Category> categories = [
      const Category(
        'Vegetables',
        'assets/images/vegetable.png',
        kAccentGreen,
      ),
      const Category(
        'Fruits',
        'assets/images/fruit.png',
        kAccentRed,
      ),
      const Category(
        'Milks & egg',
        'assets/images/egg.png',
        kAccentYellow,
      ),
      const Category(
        'Meat',
        'assets/images/meat.png',
        kAccentPurple,
      ),
      const Category(
        'Bread',
        'assets/images/bread.png',
        kAccentTosca,
      ),
      const Category(
        'Fish',
        'assets/images/seafood.png',
        kAccentGreen,
      ),
      const Category(
        'Cookies',
        'assets/images/cereal.png',
        kAccentRed,
      ),
      const Category(
        'Herbs',
        'assets/images/herbs.png',
        kAccentYellow,
      ),
      const Category(
        'Drinks',
        'assets/images/drinks.png',
        kAccentPurple,
      ),
      const Category(
        'Ice Cream',
        'assets/images/cannedfood.png',
        kAccentTosca,
      ),
      const Category(
        'Cheese',
        'assets/images/dairy.png',
        kAccentGreen,
      ),
      const Category(
        'Chips',
        'assets/images/cereal.png',
        kAccentRed,
      ),
    ];
    ScreenUtils().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              'Categories',
              [
                const Icon(
                  Icons.search,
                  color: kPrimaryBlue,
                ),
                SizedBox(
                  width: getProportionateScreenWidth(16),
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(50),
            ),
            Expanded(
                child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              children: List.generate(
                categories.length,
                (index) => CategoryCard(
                  categories[index],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
