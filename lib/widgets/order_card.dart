import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/widgets/add_buttonDouble.dart';
import 'package:sutra_ecommerce/widgets/product_card/product_card.dart';

import '../constants/colors.dart';
import '../controllers/add_to_cart_controller.dart';
import '../utils/common_functions.dart';
import '../utils/screen_utils.dart';
import 'add_button.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({
    super.key,
    this.isSelected = false,
    this.onTapHandler,
    required this.onPlusinCard,
    required this.onMinusinCard,
    required this.onAddItem,
    required this.onDeleteItem,
    required this.onChangeQty,
    this.mycartItem,
  });

  final bool isSelected;
  final Function()? onTapHandler;
  final Function(dynamic) onPlusinCard;
  final Function(dynamic) onMinusinCard;
  final Function(dynamic) onAddItem;
  final Function(dynamic) onDeleteItem;
  final Function(dynamic) onChangeQty;

  final dynamic mycartItem;

  @override
  createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  late TextEditingController _controller;
  final AddToCartController addToCartController =
      Get.put(AddToCartController());
  int quantity = 0;
  double dbquantity = 0.0;
  RxBool isWhole = false.obs;

  @override
  void initState() {
    super.initState();

    if (widget.mycartItem["count"] != null) {
      double d = double.parse(widget.mycartItem["count"].toString());
      quantity = d.toInt();
      dbquantity = d;
      _controller = TextEditingController(
          text: isWhole.value ? quantity.toString() : dbquantity.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    String multipackQtyStr =
        widget.mycartItem['product']['multipack_qty'] ?? '0.0';
    double? multipackQty = double.tryParse(multipackQtyStr);

    log("multipackQtyStr $multipackQtyStr ${widget.mycartItem['product']['multipack_qty']}");

    isWhole.value = isWholeNumber(multipackQty!);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(getProportionateScreenWidth(8)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: getProportionateScreenWidth(80),
                child: Image.network(
                  widget.mycartItem["product"]["product_img"] ??
                      "http://170.187.232.148/static/images/dilicia.png",
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(8),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.mycartItem["product"]["name"] ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: getProportionateScreenWidth(14),
                                ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              widget.onDeleteItem(isWhole.value
                                  ? quantity
                                  : dbquantity.toInt());
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 60,
                            color: Colors.white,
                            child: const Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.delete_outline_outlined,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    rateCard(
                      "Price ",
                      "${twodecimalDigit(double.parse(widget.mycartItem["product"]["price"] == null ? "0.000" : widget.mycartItem["product"]["price"].toString()))} / ${widget.mycartItem?["product"]['order_uom'] ?? ""}",
                    ),
                    rateCard(
                      "Basic Amount ",
                      twodecimalDigit(double.parse(
                          widget.mycartItem["total_value"] == null
                              ? "0.000"
                              : widget.mycartItem["total_value"].toString())),
                    ),
                    rateCard(
                      "GST ",
                      twodecimalDigit(double.parse(
                          widget.mycartItem["total_gst"] == null
                              ? "0.000"
                              : widget.mycartItem["total_gst"].toString())),
                    ),
                    Row(
                      children: [
                        Text(
                          '₹ ${twodecimalDigit(double.parse(widget.mycartItem["total_amount"] == null ? "0.000" : widget.mycartItem["total_amount"].toString()))}',
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(14),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            isWhole.value
                                ? AddButton(
                                    constWidth: true,
                                    minOrder: int.parse(convertDoubleToString(
                                        widget.mycartItem["product"]
                                                ['min_order_qty'] ??
                                            "0.0")),
                                    units:
                                        " ${widget.mycartItem?["product"]['order_uom'] ?? ""}",
                                    width: 115,
                                    textWidth: 70,
                                    isLoading: false,
                                    qty: quantity <
                                            int.parse(convertDoubleToString(
                                                widget.mycartItem["product"]
                                                        ['min_order_qty'] ??
                                                    "0.0"))
                                        ? 0
                                        : quantity,
                                    onChangedPressed: (value) {
                                      setState(() {
                                        quantity = int.parse(value);
                                        widget.onChangeQty(quantity);
                                      });
                                    },
                                    onAddPressed: () {
                                      setState(() {
                                        quantity += int.parse(
                                            convertDoubleToString(
                                                widget.mycartItem["product"]
                                                        ['min_order_qty'] ??
                                                    "0.0"));
                                        widget.onAddItem(quantity);
                                      });
                                    },
                                    onPlusPressed: () {
                                      setState(() {
                                        quantity += int.parse(
                                            convertDoubleToString(widget
                                                        .mycartItem["product"]
                                                    ['increment_order_qty'] ??
                                                "0.0"));
                                        widget.onPlusinCard(quantity);
                                      });
                                    },
                                    onMinusPressed: () {
                                      if (quantity > 0) {
                                        setState(() {
                                          quantity -= int.parse(
                                              convertDoubleToString(widget
                                                          .mycartItem["product"]
                                                      ['increment_order_qty'] ??
                                                  "0.0"));
                                          widget.onMinusinCard(quantity);
                                        });
                                      }
                                    },
                                    qtyController: _controller,
                                  )
                                : AddButtonDouble(
                                    constWidth: true,
                                    minOrder: widget.mycartItem["product"]
                                            ['min_order_qty'] ??
                                        "0.0",
                                    units:
                                        " ${widget.mycartItem?["product"]['order_uom'] ?? ""}",
                                    width: 115,
                                    textWidth: 70,
                                    isLoading: false,
                                    qty: dbquantity <
                                            double.parse(
                                                widget.mycartItem["product"]
                                                        ['min_order_qty'] ??
                                                    "0.0")
                                        ? 0
                                        : double.parse(dbquantity.toStringAsFixed(
                                            1)), // Round to two decimal places
                                    onChangedPressed: (value) {
                                      setState(() {
                                        dbquantity = double.parse(value);
                                        widget.onChangeQty(dbquantity);
                                      });
                                    },
                                    onAddPressed: () {
                                      setState(() {
                                        dbquantity += double.parse(
                                            widget.mycartItem["product"]
                                                    ['min_order_qty'] ??
                                                "0.0");
                                        widget.onAddItem(dbquantity);
                                      });
                                    },
                                    onPlusPressed: () {
                                      setState(() {
                                        dbquantity += double.parse(
                                            widget.mycartItem["product"]
                                                    ['increment_order_qty'] ??
                                                "0.0");
                                        widget.onPlusinCard(dbquantity);
                                      });
                                    },
                                    onMinusPressed: () {
                                      if (dbquantity > 0) {
                                        setState(() {
                                          dbquantity -= double.parse(
                                              widget.mycartItem["product"]
                                                      ['increment_order_qty'] ??
                                                  "0.0");
                                          widget.onMinusinCard(
                                              dbquantity.toInt());
                                        });
                                      }
                                    },
                                    qtyController: _controller,
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row rateCard(String key, String? values) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            key,
            style: TextStyle(
              color: kTextColorAccent,
              fontSize: getProportionateScreenWidth(12),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            ":  ₹ ${values ?? ""}",
            style: TextStyle(
              color: kTextColorAccent,
              fontSize: getProportionateScreenWidth(12),
            ),
          ),
        ),
      ],
    );
  }
}
