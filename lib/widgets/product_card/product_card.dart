import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/controllers/add_to_cart_controller.dart';
import 'package:sutra_ecommerce/screens/product_detail.dart/product_detail.dart';

import '../../constants/colors.dart';
import '../../utils/screen_utils.dart';

class ProductCard extends StatefulWidget {
  final dynamic product;

  final bool? isLeft;
  final bool? noPadding;
  final Function()? addHandler;

  const ProductCard({
    super.key,
    this.isLeft,
    this.addHandler,
    this.noPadding = false,
    this.product,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  RxInt quantity =
      0.obs; // Initialize quantity as observable RxInt with value 0

  @override
  void initState() {
    super.initState();

    if (widget.product != null && widget.product!["cart_count"] != null) {
      log("count::: ${widget.product!["cart_count"].toString()}");
      double? d = double.tryParse(widget.product!["cart_count"].toString());
      if (d != null) {
        log('double count $d');
        log('int count ${d.toInt()}');
        quantity.value = d.toInt();
      }
    }
  }

  final AddToCartController addToCartController =
      Get.put(AddToCartController());
  @override
  Widget build(BuildContext context) {
    //log(widget.product.toString());

    return Obx(() {
      return Padding(
        padding: !widget.noPadding!
            ? EdgeInsets.only(
                left: widget.isLeft! ? getProportionateScreenWidth(16.0) : 0,
                right: widget.isLeft! ? 0 : getProportionateScreenWidth(16.0),
              )
            : const EdgeInsets.all(0),
        child: InkWell(
          onTap: () {
            Get.toNamed(ProductDetailScreen.routeName,
                arguments:
                    ProductDetailArguments(productDetailData: widget.product));
          },
          child: Container(
            padding: EdgeInsets.all(
              getProportionateScreenWidth(1.0),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                getProportionateScreenWidth(
                  8,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: kShadowColor,
                  offset: Offset(
                    getProportionateScreenWidth(3),
                    getProportionateScreenWidth(3),
                  ),
                  blurRadius: 1,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: getProportionateScreenHeight(140.0),
                  decoration: BoxDecoration(
                    color: kGreyShade5,
                    image: DecorationImage(
                      image: NetworkImage(
                          widget.product?['product_img'] ?? "Not given"),
                      fit: BoxFit.cover, // Adjust the fit based on your needs
                    ),
                    borderRadius: BorderRadius.circular(
                      getProportionateScreenWidth(10.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(10),
                  ),
                  child: SizedBox(
                    height: getProportionateScreenHeight(80.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(
                          flex: 2,
                        ),
                        Text(
                          widget.product?['name'] ?? "Not given",
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w700, fontSize: 13),
                        ),
                        const Spacer(),
                        Text(
                          '200gr',
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            color: kTextColorAccent,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '\$45',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color:
                                      kPrimaryBlue, // Set your desired border color
                                  width: 1.0, // Set the border width
                                ),
                                borderRadius: BorderRadius.circular(
                                    10.0), // Set the border radius
                              ),
                              child: SizedBox(
                                height: 35,
                                width: quantity.value == 0
                                    ? 75
                                    : (quantity.toString().length * 11) + 75,
                                child: quantity.value == 0
                                    ? OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          side: const BorderSide(
                                              color: kPrimaryBlue),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10.0), // Set your desired border radius
                                          ),
                                        ),
                                        onPressed: () async {
                                          log('20');
                                          quantity.value++;
                                          addToCartController.productCount++;
                                          addToCartController.addToCart(
                                              quantity.value,
                                              widget.product['id'],
                                              '1');

                                          addToCartController.update();
                                        },
                                        child: Text(
                                          'Add',
                                          style: TextStyle(
                                              color: kPrimaryBlue,
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      14)),
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Transform.translate(
                                            offset: const Offset(-12, 0),
                                            child: SizedBox(
                                              width: 12,
                                              child: IconButton(
                                                padding: EdgeInsets.zero,
                                                icon: const Icon(
                                                  Icons.remove,
                                                  color: kPrimaryBlue,
                                                  size: 20,
                                                ),
                                                onPressed: () {
                                                  quantity.value--;
                                                  addToCartController
                                                      .productCount--;
                                                  addToCartController.addToCart(
                                                      quantity.value,
                                                      widget.product['id'],
                                                      '1');

                                                  addToCartController.update();
                                                },
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 35,
                                            width: (quantity.value
                                                        .toString()
                                                        .length *
                                                    11) +
                                                20,
                                            color: kPrimaryBlue,
                                            child: Center(
                                              child: Text(
                                                quantity.value.toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          Transform.translate(
                                            offset: const Offset(3.5, 0),
                                            child: SizedBox(
                                              width: 12,
                                              child: IconButton(
                                                padding: EdgeInsets.zero,
                                                icon: const Icon(
                                                  Icons.add,
                                                  color: kPrimaryBlue,
                                                  size: 20,
                                                ),
                                                onPressed: () {
                                                  quantity.value++;
                                                  addToCartController.addToCart(
                                                      quantity.value,
                                                      widget.product['id'],
                                                      '1');

                                                  addToCartController
                                                      .productCount++;
                                                  addToCartController.update();
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
