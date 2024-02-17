import 'dart:developer';

import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_input_button.dart';
import '../../widgets/discount_text.dart';
import '../../widgets/fruit_title.dart';
import '../../widgets/price_tag.dart';
import '../../widgets/product_card/product_card.dart';
import '../../widgets/quantity_input.dart';
import '../../widgets/tab_title.dart';
import '../order_summary_screen.dart';

//arguments: ProductDetailArguments(phoneNumber: phoneNumberTyped)

class ProductDetailArguments {
  final Map<String, dynamic> productDetailData;

  ProductDetailArguments({required this.productDetailData});
}

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/productDetail';

  const ProductDetailScreen({super.key});

  @override
  ProductDetailScreenState createState() => ProductDetailScreenState();
}

class ProductDetailScreenState extends State<ProductDetailScreen> {
  final textController = TextEditingController(text: '1');
  bool isReviewTab = false;

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context)?.settings.arguments as ProductDetailArguments;

    log(args.productDetailData.toString());
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar(
                      title: args.productDetailData['name'],
                      marginBottom: 12,
                      actions: [
                        const Icon(
                          Icons.share,
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
                    SizedBox(
                      height: getProportionateScreenHeight(300),
                      width: double.infinity,
                      child:
                          Image.network(args.productDetailData['product_img']),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(16.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const DiscoutText(),
                          SizedBox(
                            height: getProportionateScreenHeight(8),
                          ),
                          FruitTitle(title: args.productDetailData['name']),
                          SizedBox(
                            height: getProportionateScreenHeight(8),
                          ),
                          Text(
                            args.productDetailData['price'].toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  color: kTextColorAccent,
                                ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const PreviousPriceTag(),
                              SizedBox(
                                width: getProportionateScreenWidth(8),
                              ),
                              const PriceTag(),
                              const Spacer(),
                              CustomIconButton(Icons.remove, () {
                                setState(() {
                                  int quantity = int.parse(textController.text);
                                  quantity--;
                                  textController.text = quantity.toString();
                                });
                              }),
                              SizedBox(
                                width: getProportionateScreenWidth(4),
                              ),
                              QuantityInput(textController: textController),
                              SizedBox(
                                width: getProportionateScreenWidth(4),
                              ),
                              CustomIconButton(Icons.add, () {
                                setState(() {
                                  int quantity = int.parse(textController.text);
                                  quantity++;
                                  textController.text = quantity.toString();
                                });
                              }),
                            ],
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(8.0),
                          ),
                          Container(
                            height: getProportionateScreenHeight(
                              32,
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(2),
                              horizontal: getProportionateScreenWidth(4),
                            ),
                            decoration: ShapeDecoration(
                              color: kFillColorThird,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  getProportionateScreenWidth(8.0),
                                ),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (!isReviewTab) {
                                        return;
                                      }

                                      setState(() {
                                        isReviewTab = !isReviewTab;
                                      });
                                    },
                                    child: DetailSelection(
                                      'Detail Items',
                                      !isReviewTab,
                                    ),
                                  ),
                                ),
                                VerticalDivider(
                                  endIndent: getProportionateScreenHeight(4),
                                  indent: getProportionateScreenHeight(4),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (isReviewTab) {
                                        return;
                                      }

                                      setState(() {
                                        isReviewTab = !isReviewTab;
                                      });
                                    },
                                    child: DetailSelection(
                                      'Reviews',
                                      isReviewTab,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(16),
                          ),
                          !isReviewTab
                              ? Text(
                                  '${args.productDetailData['description']}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(
                                        color: kTextColorAccent,
                                        fontSize: 16,
                                      ),
                                )
                              : Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    const ReviewCard(),
                                    const ReviewCard(),
                                    OutlinedButton(
                                        onPressed: () {},
                                        child: const Text('See All Reviews'))
                                  ],
                                ),
                          Divider(
                            height: getProportionateScreenHeight(48),
                          ),
                          const TabTitle(
                            title: 'More Like this',
                            padding: 0,
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(220),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: ProductCard(
                                    noPadding: true,
                                  ),
                                ),
                                SizedBox(
                                  width: getProportionateScreenWidth(8),
                                ),
                                const Expanded(
                                  child: ProductCard(
                                    noPadding: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(48),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(16.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(OrderSummaryScreen.routeName);
                      },
                      child: SizedBox(
                        width: getProportionateScreenWidth(32),
                        child: Image.asset(
                          'assets/images/cart_nav_fill.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(16),
                  ),
                  Expanded(
                    flex: 4,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Buy Now'),
                    ),
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

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: getProportionateScreenHeight(8.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: kGreyShade5,
                      radius: getProportionateScreenWidth(24.0),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(8),
                    ),
                    const UserDetails(),
                  ],
                ),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: kTextColorAccent,
                      ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class UserDetails extends StatelessWidget {
  const UserDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Shoo Thar Mien',
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(17.0),
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Icon(Icons.more_vert_rounded),
            ],
          ),
          Row(
            children: [
              Image.asset(
                'assets/images/star_rating.png',
              ),
              SizedBox(
                width: getProportionateScreenWidth(4),
              ),
              Image.asset(
                'assets/images/star_rating.png',
              ),
              SizedBox(
                width: getProportionateScreenWidth(4),
              ),
              Image.asset(
                'assets/images/star_rating.png',
              ),
              SizedBox(
                width: getProportionateScreenWidth(4),
              ),
              Image.asset(
                'assets/images/star_rating.png',
              ),
              SizedBox(
                width: getProportionateScreenWidth(4),
              ),
              Image.asset(
                'assets/images/star_rating.png',
              ),
              const Text(
                '29 February, 2099',
                style: TextStyle(
                  color: kTextColorAccent,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class DetailSelection extends StatelessWidget {
  final String text;
  final bool isSelected;

  const DetailSelection(this.text, this.isSelected, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: isSelected
          ? ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  getProportionateScreenWidth(8.0),
                ),
              ),
              shadows: const [
                  BoxShadow(
                    color: kShadowColor,
                    offset: Offset(0, 3),
                    blurRadius: 8,
                  )
                ])
          : null,
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class PreviousPriceTag extends StatelessWidget {
  const PreviousPriceTag({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Divider2.png'),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(16),
          vertical: getProportionateScreenHeight(8),
        ),
        decoration: ShapeDecoration(
          color: kFailColor.withOpacity(0.15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              getProportionateScreenWidth(8.0),
            ),
          ),
        ),
        child: const Text(
          '\$126',
          style: TextStyle(
            color: kFailColor,
          ),
        ),
      ),
    );
  }
}
