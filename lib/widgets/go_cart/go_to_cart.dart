import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/constants/colors.dart';
import 'package:sutra_ecommerce/controllers/add_to_cart_controller.dart';
import 'package:sutra_ecommerce/controllers/mycart_controller.dart';
import 'package:sutra_ecommerce/utils/screen_utils.dart';

import '../../screens/cart/cart_screen.dart';
import '../../utils/common_functions.dart';

class GoToCart extends StatefulWidget {
  final String usedIn;
  const GoToCart({super.key, this.usedIn = 'all'});

  @override
  State<GoToCart> createState() => _GoToCartState();
}

class _GoToCartState extends State<GoToCart> {
  @override
  Widget build(BuildContext context) {
    final MyCartController controller = Get.put(MyCartController());
    final AddToCartController addToCartController =
        Get.put(AddToCartController());

    return Obx(() {
      final double totalAmount = double.parse(controller.mycartTotalAmount.value??"0.000");
      final int valueLength = totalAmount.toInt().toString().length;
      final double fontSize = 20 - (valueLength - 1) * 2; // Adjust the scaling factor as needed

      return Padding(
        padding: EdgeInsets.symmetric(
          vertical:
              getProportionateScreenHeight(widget.usedIn == 'Home' ? 20 : 8.0),
          horizontal: getProportionateScreenWidth(16.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.translate(
              offset: const Offset(0, -6),
              child: Container(
                width: 40, // Adjust width and height as needed
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.shopping_bag,
                  size: 30,
                  color: kPrimaryBlue,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              height: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('cart total:'),
                  Row(
                    children: [
                      Text(
                        "₹ ${twodecimalDigit(totalAmount)}",
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: fontSize),
                      ),
                      Text(" | ${addToCartController.productCount.value} items")
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        30), // Adjust the radius as needed
                  ),
                ),
                minimumSize: MaterialStateProperty.all(
                  Size(
                    getProportionateScreenWidth(2), // Width
                    getProportionateScreenHeight(40), // Height
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              child: const Text(
                'View cart',
                maxLines: 1,
                style: TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    });
  }
}
