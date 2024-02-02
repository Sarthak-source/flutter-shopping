import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomNavBar extends StatefulWidget {
  final int curTabIndex;
  final Function(int) onTap;

  const CustomNavBar(this.onTap, this.curTabIndex, {Key? key}) : super(key: key);

  @override
  CustomNavBarState createState() => CustomNavBarState();
}

class CustomNavBarState extends State<CustomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
          icon: widget.curTabIndex == 2
              ? const Icon(Icons.shopping_cart)
              : const Icon(Icons.shopping_cart_outlined),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: widget.curTabIndex == 3
              ? const Icon(Icons.person)
              : const Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
    );
  }
}
