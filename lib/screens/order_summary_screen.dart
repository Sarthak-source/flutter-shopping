import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../screens/checkout_screen.dart';
import '../utils/screen_utils.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/order_card.dart';
import '../widgets/price_breakdown.dart';

class OrderSummaryScreen extends StatelessWidget {
  static const routeName = '/orderSummary';

  const OrderSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const CustomAppBar(
                       title: 'Order Summary', actions: [],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(16.0),
                        vertical: getProportionateScreenHeight(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const OrderList(),
                          Divider(
                            height: getProportionateScreenHeight(32),
                          ),
                          Text(
                            'Promo Code',
                            style: TextStyle(
                              color: kTextColorAccent,
                              fontSize: getProportionateScreenWidth(17),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(8),
                          ),
                          const PromoInput(),
                          Divider(
                            height: getProportionateScreenHeight(56),
                          ),
                          const PriceBreakdown(
                            title: 'Sub total Price',
                            price: '\$155',
                          ),
                          const PriceBreakdown(
                            title: 'Delivery Fee',
                            price: '\$8',
                          ),
                          const PriceBreakdown(
                            title: 'TanahAir Voucher',
                            price: 'None',
                          ),
                          const PriceBreakdown(
                            title: 'Total price',
                            price: '\$163',
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
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(CheckoutScreen.routeName);
                },
                child: const Text('Checkout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderList extends StatefulWidget {
  const OrderList({
    Key? key,
  }) : super(key: key);

  @override
  OrderListState createState() => OrderListState();
}

class OrderListState extends State<OrderList> {
  int totalItem = 3;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        totalItem,
        (index) => Column(
          children: [
            OrderCard(
              key: UniqueKey(),
              isSelected: index == 0 ? true : false,
              onTapHandler: () {
                setState(() {
                  totalItem--;
                });
              },
            ),
            SizedBox(
              height: getProportionateScreenHeight(8.0),
            ),
          ],
        ),
      ),
    );
  }
}

class PromoInput extends StatelessWidget {
  const PromoInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(8.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(8.0),
          ),
          borderSide: const BorderSide(color: kGreyShade3),
        ),
        hintText: 'Enter Promo Code',
        hintStyle: TextStyle(
          fontSize: getProportionateScreenWidth(17),
          color: kTextColorThird,
        ),
        suffixIcon: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {},
              child: Text(
                'Apply',
                style: TextStyle(
                  color: kPrimaryBlue,
                  fontSize: getProportionateScreenWidth(17),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
