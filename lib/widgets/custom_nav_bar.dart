import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sutra_ecommerce/controllers/add_to_cart_controller.dart';

import '../constants/colors.dart';

class CustomNavBar extends StatefulWidget {
  final int curTabIndex;
  final Function(int) onTap;

  const CustomNavBar(this.onTap, this.curTabIndex, {Key? key})
      : super(key: key);

  @override
  CustomNavBarState createState() => CustomNavBarState();
}

class CustomNavBarState extends State<CustomNavBar> {
  @override
  Widget build(BuildContext context) {
    final AddToCartController addToCartController =
        Get.put(AddToCartController());

    return Obx(() {
      return Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 0.8)),
          // borderRadius: BorderRadius.only(
          //     topRight: Radius.circular(25), topLeft: Radius.circular(25)),
          // boxShadow: [
          //   BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          // ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
          ),
          child: BottomNavigationBar(
            onTap: (tabIndex) {
              widget.onTap(tabIndex);
            },
            selectedItemColor: kPrimaryBlue,
            unselectedItemColor: kGreyShade2,
            currentIndex: widget.curTabIndex,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                icon: widget.curTabIndex == 0
                    ? const Icon(Icons.home)
                    : const Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: widget.curTabIndex == 1
                    ? const Icon(Icons.favorite)
                    : const Icon(Icons.favorite_border),
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                icon: Stack(
                  children: [
                    widget.curTabIndex == 2
                        ? const Icon(Icons.shopping_cart)
                        : const Icon(Icons.shopping_cart_outlined),
                    if (addToCartController.productCount > 0)
                      Positioned(
                        right: 0,
                        child: Stack(
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.red[400]!,
                              highlightColor: Colors.red[100]!,
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                ),
                                width: 16,
                                height: 16,
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 8,
                              child: Text(
                                addToCartController.productCount.toString(),
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: widget.curTabIndex == 3
                    ? const Icon(Icons.person)
                    : const Icon(Icons.person_outline),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: widget.curTabIndex == 4
                    ? const Icon(Icons.payment)
                    : const Icon(Icons.payment_outlined),
                label: 'Payment',
              ),
            ],
          ),
        ),
      );
    });
  }
}
