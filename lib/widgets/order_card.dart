import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../controllers/add_to_cart_controller.dart';
import '../utils/screen_utils.dart';
import 'add_button.dart';

class OrderCard extends StatefulWidget {
  const OrderCard(
      {Key? key,
      required this.index,
      this.isSelected = false,
      this.onTapHandler,
      required this.onPlusinCard,
      required this.onMinusinCard,
      required this.onAddItem,
      required this.onDeleteItem,
      required this.onChangeQty,
      this.Txtctrlr,
      this.mycartItem})
      : super(key: key);

  final bool isSelected;
  final int index;
  final Function()? onTapHandler;
  final Function(int) onPlusinCard;
  final Function(int) onMinusinCard;
  final Function(int) onAddItem;
  final Function(int) onDeleteItem;
  final Function(int) onChangeQty;
  final TextEditingController? Txtctrlr;
  final dynamic mycartItem;
  @override
  createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  //final textController = TextEditingController(text: '1');

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

      log(quantity.toString());
      //widget.Txtctrlr?.text = quantity.toString();
      //log('widget.Txtctrlr?.text ${widget.Txtctrlr?.text}');
    }

    return Row(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(80),
          child: Image.network(
            widget.mycartItem["product"]["product_img"] ??
                "http://170.187.232.148/static/images/dilicia.png",
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
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
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
                        Icons.delete,
                        color: Colors.grey,
                      ))
                ],
              ),
              rateCard(
                  "price ", widget.mycartItem["product"]["price"].toString()),
              rateCard("gst ", widget.mycartItem["total_gst"].toString()),
              rateCard("value ", widget.mycartItem["total_value"].toString()),

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
                    '₹ ${widget.mycartItem["total_amount"].toString()}',
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
                  AddButton(
                    key: Key(widget.index.toString()),
                    isLoading: false,
                    qty: quantity,
                    onChangedPressed: (value) {
                      quantity = int.parse(value);
                      widget.Txtctrlr?.text = quantity.toString();
                      controller.rxQty.value = quantity.toString();
                      widget.onChangeQty(quantity);
                    },
                    onAddPressed: () {
                      log('widget.mycartItem["product"]["name"] ${widget.mycartItem["product"]["name"].toString()}');
                      setState(() {
                        quantity++;
                        log(quantity.toString());
                        widget.onAddItem(quantity);
                      });
                    },
                    onPlusPressed: () {
                      setState(() {
                        quantity++;
                        widget.onPlusinCard(quantity);
                      });
                    },
                    onMinusPressed: () {
                      if (quantity != 0) {
                        setState(() {
                          quantity--;
                          widget.onMinusinCard(quantity);
                        });
                      }
                    },
                    qtyController: widget.Txtctrlr,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
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
