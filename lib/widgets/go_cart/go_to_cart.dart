import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/controllers/mycart_controller.dart';
import 'package:sutra_ecommerce/screens/tab_screen/tab_screen.dart';
import 'package:sutra_ecommerce/utils/screen_utils.dart';

class GoToCart extends StatefulWidget {
  const GoToCart({super.key});

  @override
  State<GoToCart> createState() => _GoToCartState();
}

class _GoToCartState extends State<GoToCart> {
  @override
  Widget build(BuildContext context) {
    final MyCartController controller = Get.put(MyCartController());

    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 20),
      child: RawMaterialButton(
        fillColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20), // Adjust the radius as needed
        ),
        elevation: 10.0,
        onPressed: () {},
        child: Obx(() {
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(8.0),
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
                            .copyWith(
                                fontWeight: FontWeight.w700, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 60,
                ),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20), // Adjust the radius as needed
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all(
                        Size.fromHeight(
                          getProportionateScreenHeight(48),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(TabScreen.routeName);
                    },
                    child: const Text('View cart'),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
