import 'dart:developer';

import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../utils/screen_utils.dart';

class OrderCard extends StatefulWidget {
  const OrderCard(
      {super.key, this.isSelected = false, this.onTapHandler, this.mycartItem});

  final bool isSelected;
  final Function()? onTapHandler;
  final dynamic mycartItem;
  @override
  createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  //final textController = TextEditingController(text: '1');
  int quantity = 0;
  @override
  void initState() {
    super.initState();

    //if( widget.mycartItem["count"] != null){
    log("count::: ${widget.mycartItem["count"].toString()}");
    double d = double.parse(widget.mycartItem["count"].toString());
    log('double count $d');
    log('int count ${d.toInt()}');
    quantity = d.toInt();
    //}
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(80),
          child: Image.network(
            widget.mycartItem["product"]["product_img"],
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
                      widget.mycartItem["product"]["name"],
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: getProportionateScreenWidth(14),
                          ),
                    ),
                  ),
                  Text(
                    widget.mycartItem["product"]["price"].toString(),
                    style: TextStyle(
                      color: kTextColorAccent,
                      fontSize: getProportionateScreenWidth(
                        12,
                      ),
                    ),
                  ),
                ],
              ),

              Text(
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
              ),

              // Row(
              //   children: [
              //
              //     const Spacer(),
              //     CustomIconButton(
              //       Icons.remove,
              //       () {
              //         setState(() {
              //           int quantity = int.parse(textController.text);
              //           quantity--;
              //           textController.text = quantity.toString();
              //         });
              //       },
              //       size: 32,
              //     ),
              //     SizedBox(
              //       width: getProportionateScreenWidth(4),
              //     ),
              //     SmallQuantityInput(
              //       textController: textController,
              //     ),
              //     SizedBox(
              //       width: getProportionateScreenWidth(4),
              //     ),
              //     CustomIconButton(
              //       Icons.add,
              //       () {
              //         setState(() {
              //           int quantity = int.parse(textController.text);
              //           quantity++;
              //           textController.text = quantity.toString();
              //         });
              //       },
              //       size: 32,
              //     ),
              //   ],
              // )
              Row(
                children: [
                  Text(
                    '₹ ${widget.mycartItem["total_amount"].toString()}',
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(14),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: kPrimaryBlue, // Set your desired border color
                        width: 1.0, // Set the border width
                      ),
                      borderRadius: BorderRadius.circular(
                          10.0), // Set the border radius
                    ),
                    child: SizedBox(
                      height: 35,
                      width: quantity == 0
                          ? 75
                          : (quantity.toString().length * 11) + 75,
                      child: quantity == 0
                          ? OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: kPrimaryBlue),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Set your desired border radius
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                  log(quantity.toString());
                                });
                              },
                              child: const Text(
                                'Add',
                                style: TextStyle(
                                    color: kPrimaryBlue, fontSize: 14),
                              ),
                            )
                          : Row(
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
                                      onPressed: () {
                                        setState(() {
                                          quantity--;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 35,
                                  width:
                                      (quantity.toString().length * 11) + 20,
                                  color: kPrimaryBlue,
                                  child: Center(
                                    child: Text(
                                      quantity.toString(),
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
                                        setState(() {
                                          quantity++;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
