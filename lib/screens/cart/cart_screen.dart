import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sutra_ecommerce/controllers/mycart_controller.dart';

import '../../constants/colors.dart';
import '../../controllers/add_to_cart_controller.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/order_card.dart';
import '../add_address/add_address_screen.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  final MyCartController controller = Get.put(MyCartController());
  final AddToCartController addToCartController =
      Get.put(AddToCartController());
  //AddToCartController addToCartController = AddToCartController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyCartController>(builder: (controller) {
      return Obx(
        () => Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(16.0),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 18,
                ),
                Row(
                  children: [
                    Text(
                      'My Cart',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: getProportionateScreenWidth(
                              20,
                            ),
                          ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.search,
                      color: kPrimaryBlue,
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(16.0),
                ),
                Obx(
                  () => Expanded(
                    child: SingleChildScrollView(
                      child: controller.mycartItems.isEmpty
                          ? Column(
                              children: [
                                SizedBox(
                                  height: getProportionateScreenHeight(16.0),
                                ),
                                Lottie.asset('assets/lotties/cart.json',
                                    repeat: false,
                                    height: getProportionateScreenHeight(250.0),
                                    width: getProportionateScreenWidth(250.0)),
                                SizedBox(
                                  height: getProportionateScreenHeight(10.0),
                                ),
                                Text(
                                  'Oops! your cart is empty',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ],
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.mycartItems.length,
                              itemBuilder: (context, index) {
                                return OrderCard(
                                  onPlusinCard: (n) {
                                    log('add qty $n');
                                    addToCartController.updateCart(
                                        n,
                                        controller.mycartItems[index]["id"],
                                        "update",
                                        "1");
                                  },
                                  onMinusinCard: (n) {
                                    log('remove qty $n');
                                    addToCartController.updateCart(
                                        n,
                                        controller.mycartItems[index]["id"],
                                        "update",
                                        "1");
                                  },
                                  onAddItem: (n) {
                                    log('add qty $n');
                                    addToCartController.updateCart(
                                        n,
                                        controller.mycartItems[index]["id"],
                                        "update",
                                        "1");
                                  },
                                  onDeleteItem: (n) {
                                    log('delete qty $n');
                                    addToCartController.updateCart(
                                        n,
                                        controller.mycartItems[index]["id"],
                                        "delete",
                                        "1");
                                  },
                                  mycartItem: controller.mycartItems[index],
                                );
                              }),
                    ),
                  ),
                ),
                controller.mycartItems.isEmpty
                    ? const SizedBox.shrink()
                    : Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.mycartTotalValue.value,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                          color: Colors.grey, fontSize: 14),
                                ),
                                Text(
                                  controller.mycartTotalGst.value,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                          color: Colors.grey, fontSize: 14),
                                ),
                                Text(
                                  controller.mycartTotalAmount.value,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  const StadiumBorder(),
                                ),
                                minimumSize: MaterialStateProperty.all(
                                  Size.fromHeight(
                                    getProportionateScreenHeight(48),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                //Navigator.of(context).pushNamed(AddAddressScreen.routeName);
                                Get.toNamed(AddAddressScreen.routeName);
                              },
                              child: const Text('Buy Now'),
                            ),
                          ),
                        ],
                      ),
                SizedBox(
                  height: getProportionateScreenHeight(24.0),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
