import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/screens/dragon_fruit_screen.dart';

import '../constants/colors.dart';
import '../utils/screen_utils.dart';

class IndiDealCard extends StatefulWidget {
  final dynamic product;

  final bool? isLeft;
  final bool? noPadding;
  final Function()? addHandler;

  const IndiDealCard({
    super.key,
    this.isLeft,
    this.addHandler,
    this.noPadding = false,
    this.product,
  });

  @override
  State<IndiDealCard> createState() => _IndiDealCardState();
}

class _IndiDealCardState extends State<IndiDealCard> {
  int quantity = 0;
  @override
  Widget build(BuildContext context) {
    bool? isSelected = false;

    log(widget.product.toString());

    return Padding(
      padding: !widget.noPadding!
          ? EdgeInsets.only(
              left: widget.isLeft! ? getProportionateScreenWidth(16.0) : 0,
              right: widget.isLeft! ? 0 : getProportionateScreenWidth(16.0),
            )
          : const EdgeInsets.all(0),
      child: InkWell(
        onTap: () {
          setState(() {
            Get.toNamed(DragonFruitScreen.routeName);
          });
        },
        child: Container(
          padding: EdgeInsets.all(
            getProportionateScreenWidth(1.0),
          ),
          decoration: BoxDecoration(
            color: isSelected! ? Colors.white : Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(
              getProportionateScreenWidth(
                8,
              ),
            ),
            boxShadow: [
              isSelected!
                  ? BoxShadow(
                      color: kShadowColor,
                      offset: Offset(
                        getProportionateScreenWidth(24),
                        getProportionateScreenWidth(40),
                      ),
                      blurRadius: 80,
                    )
                  : const BoxShadow(color: Colors.transparent),
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
                    fit: BoxFit.contain, // Adjust the fit based on your needs
                  ),
                  borderRadius: BorderRadius.circular(
                    getProportionateScreenWidth(10.0),
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(80.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Text(
                      widget.product?['name'] ?? "Not given",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
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
                              width: quantity == 0
                                  ? 65
                                  : (quantity.toString().length * 11) + 75,
                              child: quantity == 0
                                  ? OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            color: kPrimaryBlue),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10.0), // Set your desired border radius
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          quantity++;
                                          print(quantity.toString());
                                        });
                                      },
                                      child: const Text(
                                        'Add',
                                        style: TextStyle(
                                            color: kPrimaryBlue, fontSize: 14),
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
                                                setState(() {
                                                  quantity--;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 35,
                                          width: (quantity.toString().length *
                                                  11) +
                                              20,
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
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
