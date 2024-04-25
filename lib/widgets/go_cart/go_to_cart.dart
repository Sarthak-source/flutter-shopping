import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/constants/colors.dart';
import 'package:sutra_ecommerce/controllers/add_to_cart_controller.dart';
import 'package:sutra_ecommerce/controllers/common_controller.dart';
import 'package:sutra_ecommerce/controllers/mycart_controller.dart';
import 'package:sutra_ecommerce/screens/tab_screen/tab_screen.dart';
import 'package:sutra_ecommerce/utils/screen_utils.dart';

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
    final CommonController cmncontroller = Get.put(CommonController());
    final AddToCartController addToCartController =
        Get.put(AddToCartController());

    return Obx(() {
      final double totalAmount =
          double.parse(controller.mycartTotalAmount.value ?? "0.000");
      final int valueLength = totalAmount.toInt().toString().length;
      final double fontSize =
          20 - (valueLength - 1) * 2; // Adjust the scaling factor as needed

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
              child: const SizedBox(
                width: 40, // Adjust width and height as needed
                height: 40,

                child: Icon(
                  Icons.shopping_cart_outlined,
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
                  const Text(
                    'Cart Total:',
                    style: TextStyle(fontSize: 15),
                  ),
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
                      Text(
                        " | ${addToCartController.productCount.value} Items",
                        style: TextStyle(fontSize: fontSize),
                      )
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
                    44, // Height
                  ),
                ),
              ),
              onPressed: () {
                //  Navigator.of(context).pushNamed(CartScreen.routeName);
                if (widget.usedIn == "PoductsListScreen") {
                  //Navigator.popUntil(context, ModalRoute.withName(TabScreen.routeName));
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const TabScreen(),
                    ),
                  );

                  cmncontroller.commonCurTab.value = 3;
                  cmncontroller.update();
                } else {
                  cmncontroller.commonCurTab.value = 3;
                  cmncontroller.update();
                }
              },
              child: const Text(
                'View Cart',
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
