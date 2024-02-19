import 'package:flutter/material.dart';

import '../screens/user_screen.dart';
import '../widgets/custom_nav_bar.dart';
import 'cart/cart_screen.dart';
import 'fav_screen/fav_screen.dart';
import 'home_screen/home_screen.dart';

class TabScreen extends StatefulWidget {
  static const routeName = '/tabScreen';

  const TabScreen({super.key});

  @override
  TabScreenState createState() => TabScreenState();
}

class TabScreenState extends State<TabScreen> {
  int curTab = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const HomeScreen(),
      const FavScreen(),
      CartScreen(),
      const UserScreen(),
    ];
    return Scaffold(
      body: SafeArea(
        child: pages[curTab],
      ),
      bottomNavigationBar: CustomNavBar((index) {
        setState(() {
          curTab = index;
        });
      }, curTab),
    );
  }
}
