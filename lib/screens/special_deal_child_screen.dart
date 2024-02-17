import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../utils/screen_utils.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/indi_deal_card_with_discount.dart';
//import 'package:flushbar/flushbar.dart';
import 'product_detail.dart/product_detail.dart';
import 'search_screen/search_fruit_screen.dart';

class SpecialDealChildScreen extends StatelessWidget {
  static const routeName = '/specialDealChild';

  const SpecialDealChildScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
             title: 'Fruits',
         actions:     [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(SearchFruitScreen.routeName);
                  },
                  child: const Icon(
                    Icons.search,
                    color: kPrimaryBlue,
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(16),
                ),
              ],
            ),
            const HorizontalFruitsScroll(),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: getProportionateScreenHeight(8.0),
                ),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(ProductDetailScreen.routeName);
                  },
                  child: ProductCardWithDiscount(
                    isLeft: index % 2 == 0,
                    isSelected: index == 0,
                    addHandler: () {
                      // Flushbar(
                      //   flushbarPosition: FlushbarPosition.TOP,
                      //   duration: const Duration(seconds: 3),
                      //   backgroundColor: kPrimaryRed,
                      //   icon: Image.asset('assets/images/delivery.png'),
                      //   padding: EdgeInsets.symmetric(
                      //     vertical: getProportionateScreenHeight(24.0),
                      //   ),
                      //   margin: EdgeInsets.only(
                      //     top: getProportionateScreenHeight(
                      //       32,
                      //     ),
                      //   ),
                      //   message:
                      //       'Free shipping with a minimum purchase of \$ 100',
                      // )..show(context);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HorizontalFruitsScroll extends StatefulWidget {
  const HorizontalFruitsScroll({
    Key? key,
  }) : super(key: key);

  @override
  HorizontalFruitsScrollState createState() => HorizontalFruitsScrollState();
}

class HorizontalFruitsScrollState extends State<HorizontalFruitsScroll> {
  int curIndex = 0;
  final List<Map<String, Object>> fruitVariety = [
    {
      'name': 'All',
      'index': 0,
    },
    {
      'name': 'Apples',
      'index': 1,
    },
    {
      'name': 'Avocado',
      'index': 2,
    },
    {
      'name': 'Banana',
      'index': 3,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(64),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            fruitVariety.length,
            (index) => SelectionTab(
              text: fruitVariety[index]['name'] as String,
              isSelected: curIndex == index,
              onTap: () {
                setState(() {
                  curIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}

class SelectionTab extends StatelessWidget {
  final String? text;
  final Function()? onTap;
  final bool? isSelected;

  const SelectionTab({super.key, 
    this.text,
    this.onTap,
    this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(4.0),
        ),
        margin: EdgeInsets.only(
          left: getProportionateScreenWidth(16.0),
        ),
        constraints: const BoxConstraints.tightFor(width: 96.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(8.0),
          ),
          border: isSelected!
              ? Border.all(
                  color: kPrimaryBlue,
                  width: 2,
                )
              : null,
        ),
        child: Text(
          text!,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected! ? kPrimaryBlue : Colors.black,
          ),
        ),
      ),
    );
  }
}
