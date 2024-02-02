import 'package:flutter/material.dart';

import '../screens/add_address/add_address_screen.dart';
import '../screens/category_screen.dart';
import '../screens/checkout_screen.dart';
import '../screens/dragon_fruit_screen.dart';
import '../screens/fruit_screen.dart';
import '../screens/intro_screen/intro_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/map_screen.dart';
import '../screens/my_profile_screen.dart';
import '../screens/order_success_screen.dart';
import '../screens/order_summary_screen.dart';
import '../screens/popular_deals_screen.dart';
import '../screens/search_fruit_screen.dart';
import '../screens/search_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/special_deal_child_screen.dart';
import '../screens/special_deal_screen.dart';
import '../screens/tab_screen.dart';
import '../screens/vegetable_screen.dart';

class Route {
  Map<String, Widget Function(BuildContext)> routes = {
    IntroScreen.routeName: (ctx) => const IntroScreen(),
    LoginScreen.routeName: (ctx) => const LoginScreen(),
    SignupScreen.routeName: (ctx) => const SignupScreen(),
    AddAddressScreen.routeName: (ctx) => const AddAddressScreen(),
    MapScreen.routeName: (ctx) => const MapScreen(),
    TabScreen.routeName: (ctx) => const TabScreen(),
    SearchScreen.routeName: (ctx) => const SearchScreen(),
    VegetableScreen.routeName: (ctx) => const VegetableScreen(),
    FruitScreen.routeName: (ctx) => const FruitScreen(),
    CategoryScreen.routeName: (ctx) => const CategoryScreen(),
    PopularDealsScreen.routeName: (ctx) => const PopularDealsScreen(),
    SpecialDealScreen.routeName: (ctx) => const SpecialDealScreen(),
    SpecialDealChildScreen.routeName: (ctx) => const SpecialDealChildScreen(),
    SearchFruitScreen.routeName: (ctx) => const SearchFruitScreen(),
    DragonFruitScreen.routeName: (ctx) => const DragonFruitScreen(),
    OrderSummaryScreen.routeName: (ctx) => const OrderSummaryScreen(),
    CheckoutScreen.routeName: (ctx) => const CheckoutScreen(),
    OrderSuccessScreen.routeName: (ctx) => const OrderSuccessScreen(),
    MyProfileScreen.routeName: (ctx) => const MyProfileScreen(),
  };
}
