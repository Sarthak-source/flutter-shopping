import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/controllers/add_to_cart_controller.dart';
import 'package:sutra_ecommerce/controllers/products_controller.dart';
import 'package:sutra_ecommerce/utils/common_functions.dart';
import 'package:sutra_ecommerce/widgets/add_button.dart';
import 'package:sutra_ecommerce/widgets/add_buttonDouble.dart';
import 'package:sutra_ecommerce/widgets/popular_card/popular_card.dart';

import '../../config/common.dart';
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

  const ProductCard({
    super.key,
    this.isLeft,
    this.addHandler,
    this.loader,
    this.noPadding = false,
    this.product,
    required this.onCardAddClicked,
    required this.onCardMinusClicked,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final TextEditingController quantityCtrlr = TextEditingController();

  RxInt quantity = 0.obs;
  RxString dblquantity = "0.0".obs;
  String ordersMilk = "";
  RxBool isWhole = true.obs;

  @override
  void initState() {
    super.initState();
    Map storedUserData = box!.get('userData');
    print(
        'userdata in popularcard ${storedUserData['party']['orders_milk'].toString()}');
    ordersMilk = storedUserData['party']['orders_milk']?.toString() ?? "";

    String multipackQtyStr = widget.product['multipack_qty'] ?? '0.0';
    double? multipackQty = double.tryParse(multipackQtyStr);

    isWhole.value = isWholeNumber(multipackQty!);
    log("multipack_qtytest $multipackQtyStr ${isWhole.value}");

    if (widget.product != null && widget.product!["cart_count"] != null) {
      final cartCount = widget.product["cart_count"] ?? "null";
      if (cartCount != null) {
        log("count::: ${cartCount.toString()}");
        final double? parsedCount = double.tryParse(cartCount.toString());
        if (parsedCount != null) {
          log('double count $parsedCount');
          log('int count ${parsedCount.toInt()}');
          log("quantitydata ${quantity.value.toString()}");

          if (quantity.value == 0 && dblquantity.value == "0.0") {
            if (isWhole.value) {
              quantity.value = parsedCount.toInt();
            } else {
              dblquantity.value = cartCount.toString();
            }
          }
        }
      }
    }
  }

  final AddToCartController addToCartController =
      Get.put(AddToCartController());

  @override
  Widget build(BuildContext context) {
    log("category123 ${widget.product['category']}");

    final ProductController productControler = Get.put(
        ProductController(categoryId: widget.product['category'].toString()));

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
          padding: EdgeInsets.all(getProportionateScreenWidth(0.0)),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(getProportionateScreenWidth(8)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   height: getProportionateScreenHeight(100.0),
              //   decoration: BoxDecoration(
              //     borderRadius:
              //         BorderRadius.circular(getProportionateScreenWidth(10.0)),
              //   ),
              //   child: Center(
              //     child: FadeInImage(
              //       placeholder:
              //            const AssetImage('assets/images/dilicia-logos-placeholder.png',),
              //       image: NetworkImage(
              //         widget.product?['product_img'] ??
              //             'http://170.187.232.148/static/images/dilicia.png',
              //       ),
              //       fit: BoxFit.fill,
              //       height: getProportionateScreenHeight(100),
              //     ),
              //   ),
              // ),
              Container(
                height: getProportionateScreenHeight(100.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        widget.product?['product_img'] ?? "Not given"),
                    fit: BoxFit.contain,
                    scale: 0.4,
                  ),
                  borderRadius:
                      BorderRadius.circular(getProportionateScreenWidth(10.0)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(10),
                  vertical: getProportionateScreenHeight(5),
                ),
                child: SizedBox(
                  height: getProportionateScreenHeight(55.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product?['name'] ?? "Not given",
                        maxLines: 2,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w700, fontSize: 13),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            "${convertDoubleToString(widget.product?['packing_qty'].toString() ?? '0.0')} ${widget.product?['packing_uom']}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: kTextColorAccent,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "₹ ${convertDoubleToString(widget.product?['price'].toString() ?? '0.0 ')}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                          ),
                          Text(
                            " / ${widget.product?['order_uom'] ?? ""}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 10,
                                  color: kTextColorAccent,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: isWhole.value
                    ? AddButton(
                        minOrder: int.parse(convertDoubleToString(
                            widget.product['min_order_qty'] ?? "0.0")),
                        units: " ${widget.product?['order_uom'] ?? ""}",
                        width: 165,
                        textWidth: 150,
                        isLoading: widget.loader ?? false,
                        qty: quantity.value <
                                int.parse(convertDoubleToString(
                                    widget.product['min_order_qty'] ?? "0.0"))
                            ? 0
                            : quantity.value,
                        onChangedPressed: (value) {
                          quantity.value = int.parse(value);
                          quantityCtrlr.text = quantity.value.toString();
                          controller.rxQty.value = quantity.value.toString();
                          addToCartController.addToCart(quantity.value,
                              widget.product?['id'], '1', widget.product);
                          productControler.fetchProducts();
                        },
                        onAddPressed: () {
                          String minOrder =
                              widget.product['min_order_qty']?.toString() ??
                                  "0.0";
                          quantity.value +=
                              int.parse(convertDoubleToString(minOrder));
                          addToCartController.productCount++;
                          addToCartController.addToCart(quantity.value,
                              widget.product?['id'], '1', widget.product);
                          quantityCtrlr.text = quantity.value.toString();
                          controller.rxQty.value = quantity.value.toString();
                          addToCartController.update();
                          productControler.fetchProducts();
                        },
                        onPlusPressed: () {
                          widget.onCardAddClicked();
                          String minOrder = widget
                                  .product['increment_order_qty']
                                  ?.toString() ??
                              "0.0";
                          quantity.value +=
                              int.parse(convertDoubleToString(minOrder));
                          quantityCtrlr.text = quantity.value.toString();
                          addToCartController.addToCart(quantity.value,
                              widget.product?['id'], '1', widget.product);
                          addToCartController.productCount++;
                          productControler.fetchProducts();
                          addToCartController.update();
                        },
                        onMinusPressed: () {
                          widget.onCardMinusClicked();
                          String minOrder = widget
                                  .product['increment_order_qty']
                                  ?.toString() ??
                              "0.0";
                          quantity.value -=
                              int.parse(convertDoubleToString(minOrder));
                          addToCartController.productCount--;
                          quantityCtrlr.text = quantity.value.toString();
                          controller.rxQty.value = quantity.value.toString();
                          addToCartController.addToCart(quantity.value,
                              widget.product?['id'], '1', widget.product);
                          if (quantity.value <
                              int.parse(convertDoubleToString(
                                  widget.product['min_order_qty'] ?? "0.0"))) {
                            quantity.value = 0;
                          }
                          addToCartController.update();
                          productControler.fetchProducts();
                        },
                        qtyController: quantityCtrlr,
                        parentCode: widget.product?['parent_code'] ?? "",
                      )
                    : AddButtonDouble(
                        minOrder:
                            (widget.product['min_order_qty']?.toString() ??
                                "0.0"),
                        units: " ${widget.product?['order_uom'] ?? ""}",
                        width: 165,
                        textWidth: 150,
                        isLoading: widget.loader ?? false,
                        qty: double.parse(dblquantity.value) <
                                double.parse(
                                    widget.product['min_order_qty'] ?? "0.0")
                            ? 0
                            : double.parse(dblquantity.value)
                                .toStringAsFixed(1),
                        onChangedPressed: (value) {
                          dblquantity.value =
                              double.parse(value).toStringAsFixed(1);
                          quantityCtrlr.text = dblquantity.value;
                          controller.rxQty.value = dblquantity.value;
                          addToCartController.addToCart(
                              double.parse(dblquantity.value),
                              widget.product?['id'],
                              '1',
                              widget.product);
                          productControler.fetchProducts();
                        },
                        onAddPressed: () {
                          double minOrder = double.parse(
                              widget.product['min_order_qty']?.toString() ??
                                  "0.0");
                          double currentQty = double.parse(dblquantity.value);
                          dblquantity.value =
                              (currentQty + minOrder).toStringAsFixed(2);
                          addToCartController.productCount++;
                          addToCartController.addToCart(
                              double.parse(dblquantity.value),
                              widget.product?['id'],
                              '1',
                              widget.product);
                          quantityCtrlr.text = dblquantity.value;
                          controller.rxQty.value = dblquantity.value;
                          addToCartController.update();
                          productControler.fetchProducts();
                        },
                        onPlusPressed: () {
                          widget.onCardAddClicked();
                          double incrementQty = double.parse(widget
                                  .product['increment_order_qty']
                                  ?.toString() ??
                              "0.0");
                          double currentQty = double.parse(dblquantity.value);
                          dblquantity.value =
                              (currentQty + incrementQty).toStringAsFixed(1);
                          quantityCtrlr.text = dblquantity.value;
                          addToCartController.addToCart(
                              double.parse(dblquantity.value),
                              widget.product?['id'],
                              '1',
                              widget.product);
                          addToCartController.productCount++;
                          addToCartController.update();
                          productControler.fetchProducts();
                        },
                        onMinusPressed: () {
                          widget.onCardMinusClicked();
                          double incrementQty = double.parse(widget
                                  .product['increment_order_qty']
                                  ?.toString() ??
                              "0.0");
                          double currentQty = double.parse(dblquantity.value);
                          dblquantity.value =
                              (currentQty - incrementQty).toStringAsFixed(1);
                          addToCartController.productCount--;
                          quantityCtrlr.text = dblquantity.value;
                          controller.rxQty.value = dblquantity.value;
                          addToCartController.addToCart(
                              double.parse(dblquantity.value),
                              widget.product?['id'],
                              '1',
                              widget.product);
                          if (double.parse(dblquantity.value) <
                              double.parse(
                                  widget.product['min_order_qty']?.toString() ??
                                      "0.0")) {
                            dblquantity.value = "0.0";
                          }
                          addToCartController.update();
                          productControler.fetchProducts();
                        },
                        qtyController: quantityCtrlr,
                        parentCode: widget.product?['parent_code'] ?? "",
                      ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    (isWhole.value
                                ? quantity.value
                                : double.parse(dblquantity.value)) ==
                            0
                        ? const Text("")
                        : Text(
                            isWhole.value
                                ? setCrateRate(
                                    quantity.value,
                                    widget.product?['multipack_qty'] ?? "0.0",
                                    widget.product?['multipack_uom'] ?? "",
                                    widget.product?['parent_code'] ?? "",
                                    ordersMilk,
                                  ).toString()
                                : setCrateRateDouble(
                                    double.parse(dblquantity.value),
                                    widget.product?['multipack_qty'] ?? "0.0",
                                    widget.product?['multipack_uom'] ?? "",
                                    widget.product?['parent_code'] ?? "",
                                    ordersMilk),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontSize: 12, color: kTextColorAccent),
                          ),
                    Text(
                      " ${widget.product?['multipack_uom'] ?? ""}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 12, color: kTextColorAccent),
                    ),
                    const Spacer(),
                    Text(
                      isWhole.value
                          ? "${setPackingValue(quantity.value, widget.product['packing_qty'] ?? "0.0", widget.product?['multipack_uom'] ?? "", widget.product?['no_of_pieces'] ?? 0, widget.product?['order_uom'] ?? '', widget.product?['packing_uom'] ?? '', ordersMilk, widget.product?['parent_code'] ?? "")} "
                          : "${setPackingValueDouble(double.parse(dblquantity.value), widget.product['packing_qty'] ?? "0.0", widget.product?['multipack_uom'] ?? "", widget.product?['no_of_pieces'] ?? 0, widget.product?['order_uom'] ?? '', widget.product?['packing_uom'] ?? '', ordersMilk, widget.product?['parent_code'] ?? "")} ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 12, color: kTextColorAccent),
                    ),
                    Text(
                      "Nos",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 12, color: kTextColorAccent),
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

bool isWholeNumber(double number) {
  return number == number.toInt();
}
