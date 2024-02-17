import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../screens/special_deal_child_screen.dart';
import '../utils/screen_utils.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/deal_card.dart';

class SpecialDealScreen extends StatelessWidget {
  static const routeName = '/special_deal';

  const SpecialDealScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              
            actions:  [
                const Icon(
                  Icons.search,
                  color: kPrimaryBlue,
                ),
                SizedBox(
                  width: getProportionateScreenWidth(16),
                ),
              ], title:'Special Deals for You',
            ),
            SizedBox(
              height: getProportionateScreenHeight(32),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(16.0),
                ),
                children: [
                  DealCard(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(SpecialDealChildScreen.routeName);
                    },
                    isHorizontalScrolling: false,
                  ),
                  const DealCard(
                    isHorizontalScrolling: false,
                  ),
                  const DealCard(
                    isHorizontalScrolling: false,
                  ),
                  const DealCard(
                    isHorizontalScrolling: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
