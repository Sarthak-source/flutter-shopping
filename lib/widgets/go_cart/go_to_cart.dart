import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/controllers/mycart_controller.dart';
import 'package:sutra_ecommerce/utils/screen_utils.dart';

import '../../screens/cart/cart_screen.dart';

class GoToCart extends StatefulWidget {
  final String usedIn;
  const GoToCart({super.key, this.usedIn='all'});

  @override
  State<GoToCart> createState() => _GoToCartState();
}

class _GoToCartState extends State<GoToCart> {
  @override
  Widget build(BuildContext context) {
    final MyCartController controller = Get.put(MyCartController());

    return Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(widget.usedIn=='Home'? 20: 8.0),
          horizontal: getProportionateScreenWidth(16.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('cart total:'),
                  Text(
                    "₹ ${controller.mycartTotalAmount.value}",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 150,
            ),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          30), // Adjust the radius as needed
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(
                    Size.fromHeight(
                      getProportionateScreenHeight(48),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                child: const Text('View cart'),
              ),
            ),
          ],
        ),
      );
    });
  }
}
