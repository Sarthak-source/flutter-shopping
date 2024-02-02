import 'package:flutter/material.dart';

import '../widgets/list_card.dart';
import '../constants/colors.dart';
import '../utils/screen_utils.dart';
import '../widgets/custom_app_bar.dart';

class VegetableScreen extends StatelessWidget {
  static const routeName = '/vegetable_screen';

  const VegetableScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              'Featured Vegetables',
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
              height: getProportionateScreenHeight(10),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: const [
                  ListCard(
                    isSelected: true,
                    isDiscount: true,
                  ),
                  ListCard(
                    isSelected: false,
                    isDiscount: true,
                  ),
                  ListCard(
                    isSelected: false,
                    isDiscount: true,
                  ),
                  ListCard(
                    isSelected: false,
                    isDiscount: true,
                  ),
                  ListCard(
                    isSelected: false,
                    isDiscount: false,
                  ),
                  ListCard(
                    isSelected: false,
                    isDiscount: false,
                  ),
                  ListCard(
                    isSelected: false,
                    isDiscount: false,
                  ),
                  ListCard(
                    isSelected: false,
                    isDiscount: false,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
