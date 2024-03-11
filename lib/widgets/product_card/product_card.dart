import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/controllers/add_to_cart_controller.dart';
import 'package:sutra_ecommerce/utils/common_functions.dart';
import 'package:sutra_ecommerce/widgets/add_button.dart';

import '../../constants/colors.dart';
import '../../utils/screen_utils.dart';

class ProductCard extends StatefulWidget {
  final dynamic product;

  final bool? isLeft;
  final bool? noPadding;
  final bool? loader;
  final Function()? addHandler;
  final Function() onCardAddClicked;
  final Function() onCardMinusClicked;

  const ProductCard(
      {super.key,
      this.isLeft,
      this.addHandler,
      this.loader,
      this.noPadding = false,
      this.product,
      required this.onCardAddClicked,
      required this.onCardMinusClicked});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final TextEditingController quantityCtrlr = TextEditingController();

  RxInt quantity =
      0.obs; // Initialize quantity as observable RxInt with value 0

  @override
  void initState() {
    super.initState();

    if (widget.product != null && widget.product!["cart_count"] != null) {
      final cartCount = widget.product!["cart_count"];
      if (cartCount != null) {
        log("count::: ${cartCount.toString()}");
        final double? parsedCount = double.tryParse(cartCount.toString());
        if (parsedCount != null) {
          log('double count $parsedCount');
          log('int count ${parsedCount.toInt()}');
          quantity.value = parsedCount.toInt();
        }
      }
    }
  }

  final AddToCartController addToCartController =
      Get.put(AddToCartController());
  @override
  Widget build(BuildContext context) {
    log(widget.product.toString());

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
            //log(widget.product.toString());
            // Get.toNamed(ProductDetailScreen.routeName,
            //     arguments: ProductDetailArguments(productDetailData: widget.product));
          },
          child: Container(
            padding: EdgeInsets.all(
              getProportionateScreenWidth(1.0),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey, // Border color
                width: 1.0, // Border width
              ),
              borderRadius: BorderRadius.circular(
                getProportionateScreenWidth(
                  8,
                ),
              ),
              // boxShadow: [
              //   BoxShadow(
              //     color: kShadowColor,
              //     offset: Offset(
              //       getProportionateScreenWidth(3),
              //       getProportionateScreenWidth(3),
              //     ),
              //     blurRadius: 1,
              //   )
              // ],
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
                      fit: BoxFit.cover,
                      scale: 0.4, // Adjust the fit based on your needs
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
                        Hero(
                          tag: 'productDetailName',
                          child: Text(
                            widget.product?['name'] ?? "Not given",
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.w700, fontSize: 13),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "${convertDoubleToString(widget.product?['packing_qty'].toString() ?? '0.0')} ${widget.product?['packing_uom']}",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            color: kTextColorAccent,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    "₹ ${convertDoubleToString(widget.product?['price'].toString() ?? '0.0 ')}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            AddButton(
                              // width: 135,
                              // textWidth: 120,
                              isLoading: widget.loader ?? false,
                              qty: quantity.value <
                                      int.parse(convertDoubleToString(
                                          widget.product['min_order_qty'] ??
                                              "0.0"))
                                  ? 0
                                  : quantity.value,
                              onChangedPressed: (value) {
                                quantity.value = int.parse(value);
                                quantityCtrlr.text = quantity.value.toString();
                                controller.rxQty.value =
                                    quantity.value.toString();

                                addToCartController.addToCart(
                                    quantity.value, widget.product?['id'], '1');
                              },
                              onAddPressed: () {
                                //  quantity.value++;
                                String minOrder =
                                    widget.product['min_order_qty'] == null
                                        ? "0.0"
                                        : widget.product['min_order_qty']
                                            .toString();
                                quantity.value = quantity.value +
                                    int.parse(convertDoubleToString(minOrder));
                                print(
                                    'onClick of Add ${int.parse(convertDoubleToString(minOrder))} :: ${quantity.value}');
                                addToCartController.productCount++;
                                addToCartController.addToCart(
                                    quantity.value, widget.product?['id'], '1');
                                addToCartController.update();
                                quantityCtrlr.text = quantity.value.toString();
                                controller.rxQty.value =
                                    quantity.value.toString();
                              },
                              onPlusPressed: () {
                                widget.onCardAddClicked();
                                //  final ValueNotifier<bool> isLoadingButton1 = ValueNotifier(false);
                                print(
                                    'isloading in addtocart ${addToCartController.isLoading.value}');
                                controller.rxQty.value =
                                    quantity.value.toString();
                                String minOrder = widget
                                        .product['increment_order_qty']
                                        .toString() ??
                                    "0.0";
                                quantity.value = quantity.value +
                                    int.parse(convertDoubleToString(minOrder));
                                quantityCtrlr.text = quantity.value.toString();
                                addToCartController.addToCart(
                                    quantity.value, widget.product?['id'], '1');

                                addToCartController.productCount++;
                                addToCartController.update();
                              },
                              onMinusPressed: () {
                                widget.onCardMinusClicked();
                                //   if (quantity.value > 0) {
                                // quantity.value--;
                                String minOrder = widget
                                        .product['increment_order_qty']
                                        .toString() ??
                                    "0.0";
                                quantity.value = quantity.value -
                                    int.parse(convertDoubleToString(minOrder));
                                addToCartController.productCount--;
                                quantityCtrlr.text = quantity.value.toString();
                                controller.rxQty.value =
                                    quantity.value.toString();
                                addToCartController.addToCart(
                                    quantity.value, widget.product?['id'], '1');
                                addToCartController.update();
                                //  }

                                /* quantity.value--;
                    addToCartController.productCount--;
                    addToCartController.addToCart(
                        quantity.value,
                        widget.product?['id'],
                        '1');
                    addToCartController.update();*/
                              },
                              qtyController: quantityCtrlr,
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
