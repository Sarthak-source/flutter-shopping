import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../controllers/add_to_cart_controller.dart';
import '../utils/common_functions.dart';
import '../utils/screen_utils.dart';
import 'add_button.dart';

class OrderCard extends StatefulWidget {
  const OrderCard(
      {super.key,
      this.isSelected = false,
      this.onTapHandler,
      required this.onPlusinCard,
      required this.onMinusinCard,
      required this.onAddItem,
      required this.onDeleteItem,
      required this.onChangeQty,
      this.mycartItem});

  final bool isSelected;
  final Function()? onTapHandler;
  final Function(int) onPlusinCard;
  final Function(int) onMinusinCard;
  final Function(int) onAddItem;
  final Function(int) onDeleteItem;
  final Function(int) onChangeQty;

  final dynamic mycartItem;
  @override
  createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  //final textController = TextEditingController(text: '1');
  late TextEditingController _controller;
  final AddToCartController addToCartController =
      Get.put(AddToCartController());
  int quantity = 0;
  @override
  void initState() {
    super.initState();

    //if( widget.mycartItem["count"] != null){
/*  print("count::: ${widget.mycartItem["count"].toString()}");


  double d = double.parse(widget.mycartItem["count"].toString());
  print('double count $d');
  print('int count ${d.toInt()}');
  quantity = d.toInt();*/
    //}

    // widget.Txtctrlr?.text=quantity.toString();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.mycartItem["count"] != null) {
      print("count::: ${widget.mycartItem["count"].toString()}");
      double? d = double.parse(widget.mycartItem["count"].toString());
      print('double count $d');
      print('int count ${d.toInt()}');
      quantity = d.toInt();
      _controller = TextEditingController(text: quantity.toString());
      // widget.Txtctrlr?.text=quantity.toString();
    }

    log(widget.mycartItem.toString());

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey, // Border color
            width: 1.0, // Border width
          ),
          borderRadius: BorderRadius.circular(getProportionateScreenWidth(8)),
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
                        /*      Text(
                            widget.mycartItem["product"]["price"].toString(),
                            style: TextStyle(
                              color: kTextColorAccent,
                              fontSize: getProportionateScreenWidth(
                                12,
                              ),
                            ),
                          ),*/
                        const SizedBox(
                          width: 8,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              widget.onDeleteItem(quantity);
                            });
                          },
                          child: const Icon(
                            Icons.delete_outline_outlined,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                    rateCard(
                      "Price ",
                      "${twodecimalDigit(double.parse(widget.mycartItem["product"]["price"] == null ? "0.000" : widget.mycartItem["product"]["price"].toString()))} / ${widget.mycartItem?["product"]['order_uom'] == null ? "" : widget.mycartItem?["product"]['order_uom']}",
                    ),
                    rateCard(
                        "Gst ",
                        twodecimalDigit(double.parse(
                            widget.mycartItem["total_gst"] == null
                                ? "0.000"
                                : widget.mycartItem["total_gst"].toString()))),
                    rateCard(
                        "Value ",
                        twodecimalDigit(double.parse(
                            widget.mycartItem["total_value"] == null
                                ? "0.000"
                                : widget.mycartItem["total_value"]
                                    .toString()))),

                    /*    Text(
                        widget.mycartItem["total_value"].toString(),
                        style: TextStyle(
                          color: kTextColorAccent,
                          fontSize: getProportionateScreenWidth(
                            12,
                          ),
                        ),
                      ),
                      Text(
                        widget.mycartItem["total_gst"].toString(),
                        style: TextStyle(
                          color: kTextColorAccent,
                          fontSize: getProportionateScreenWidth(
                            12,
                          ),
                        ),
                      ),*/

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

                        /* Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: kPrimaryBlue, // Set your desired border color
                                width: 1.0, // Set the border width
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: SizedBox(
                              height: 35,
                              width:  quantity == 0 ? 75
                                  : ( quantity.toString().length * 11) + 75,
                              child:  quantity == 0
                                  ? OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(color: kPrimaryBlue),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10.0), // Set your desired border radius
                                        ),
                                      ),
                                      onPressed: () {
                                        log('widget.mycartItem["product"]["name"] ${widget.mycartItem["product"]["name"].toString()}');
                                          setState(() {
                                          quantity++;
                                          log(quantity.toString());
                                          widget.onAddItem(quantity);
                                        });
                                      },
                                      child: const Text(
                                        'Add',
                                        style: TextStyle(
                                            color: kPrimaryBlue, fontSize: 14),
                                      ),
                                    )
                                  : PlusMinusUI(
                                onPlusPressed: (){
                                      setState(() {
                                        quantity++;
                                        widget.onPlusinCard(quantity);
                                      });
                                      },
                                    onMinusPressed: (){
                                      if (quantity != 0) {
                                        setState(() {
                                          quantity--;
                                          widget.onMinusinCard(quantity);
                                        });
                
                                      }
                                    },
                                    qty: quantity,
                              ),
                                  // :
                
                
                            ),
                          ),*/
                        Column(
                          children: [
                            AddButton(
                              constWidth:true,
                              minOrder: int.parse(convertDoubleToString(
                                  widget.mycartItem['min_order_qty'] ?? "0.0")),
                              units:
                                  " ${widget.mycartItem?['order_uom'] == null ? "" : widget.mycartItem?['order_uom']}",
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
                                quantity = int.parse(value);
                                //  widget.Txtctrlr?.text =quantity.toString();
                                // controller.rxQty.value = quantity.toString();
                                widget.onChangeQty(quantity);
                              },
                              onAddPressed: () {
                                log('widget.mycartItem["product"]["name"] ${widget.mycartItem["product"]["name"].toString()}');
                                setState(() {
                                  // quantity++;
                                  String minOrder = widget.mycartItem["product"]
                                              ['min_order_qty'] ==
                                          null
                                      ? "0.0"
                                      : widget.mycartItem["product"]
                                              ['min_order_qty']
                                          .toString();

                                  quantity = quantity +
                                      int.parse(
                                          convertDoubleToString(minOrder));
                                  log(quantity.toString());
                                  widget.onAddItem(quantity);
                                });
                              },
                              onPlusPressed: () {
                                setState(() {
                                  //  quantity++;
                                  String minOrder = widget.mycartItem["product"]
                                              ['increment_order_qty']
                                          .toString() ??
                                      "0.0";
                                  quantity = quantity +
                                      int.parse(
                                          convertDoubleToString(minOrder));
                                  widget.onPlusinCard(quantity);
                                });
                              },
                              onMinusPressed: () {
                                if (quantity != 0) {
                                  setState(() {
                                    //  quantity--;
                                    String minOrder = widget
                                            .mycartItem["product"]
                                                ['increment_order_qty']
                                            .toString() ??
                                        "0.0";
                                    quantity = quantity -
                                        int.parse(
                                            convertDoubleToString(minOrder));
                                    widget.onMinusinCard(quantity);
                                  });
                                }
                              },
                              qtyController: _controller, //widget.Txtctrlr,
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
              fontSize: getProportionateScreenWidth(
                12,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            ":  ₹ ${values ?? ""}",
            //widget.mycartItem["product"]["price"].toString(),
            style: TextStyle(
              color: kTextColorAccent,
              fontSize: getProportionateScreenWidth(
                12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PlusMinusUI extends StatelessWidget {
  final Function() onPlusPressed;
  final Function() onMinusPressed;
  final int qty;
  const PlusMinusUI(
      {super.key,
      required this.onPlusPressed,
      required this.onMinusPressed,
      required this.qty});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
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
                onPressed: onMinusPressed),
          ),
        ),
        Container(
          height: 35,
          width: (qty.toString().length * 11) + 20,
          color: kPrimaryBlue,
          child: Center(
            child: Text(
              qty.toString(),
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
                onPressed: onPlusPressed),
          ),
        ),
      ],
    );
  }
}
