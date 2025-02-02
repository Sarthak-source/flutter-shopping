import 'package:get/get.dart';
import 'package:sutra_ecommerce/controllers/add_to_cart_controller.dart';
import 'package:sutra_ecommerce/screens/add_address/post_address.dart';
import 'package:sutra_ecommerce/screens/login/verify_otp.dart';
import 'package:sutra_ecommerce/screens/notification/notification.dart';
import 'package:sutra_ecommerce/screens/paymentScreen/paymentScreen.dart';
import 'package:sutra_ecommerce/screens/product_detail.dart/product_detail.dart';
import 'package:sutra_ecommerce/screens/select_time/select_time.dart';
import 'package:sutra_ecommerce/screens/sign_up/sign_message_screen.dart';
import 'package:sutra_ecommerce/screens/sign_up/sign_wait_screen.dart';

import '../screens/add_address/add_address_screen.dart';
import '../screens/cart/cart_screen.dart';
import '../screens/category_screen/category_screen.dart';
import '../screens/checkout_screen.dart';
import '../screens/fruit_screen.dart';
import '../screens/intro_screen/intro_screen.dart';
import '../screens/landing_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/map_screen.dart';
import '../screens/my_profile_screen.dart';
import '../screens/myorders_screen.dart';
import '../screens/order_success_screen/order_success_screen.dart';
import '../screens/order_summary_screen.dart';
import '../screens/paymentScreen/selectPaymentMethod.dart';
import '../screens/product_grid_screen/produts_grid_screen.dart';
import '../screens/search_screen/search_fruit_screen.dart';
import '../screens/search_screen/search_screen.dart';
import '../screens/sign_up/signup_screen.dart';
import '../screens/special_deal_screen.dart';
import '../screens/tab_screen/tab_screen.dart';

List<GetPage> pages = [
  GetPage(name: IntroScreen.routeName, page: () => const IntroScreen()),
  GetPage(name: LandingScreen.routeName, page: () => const LandingScreen()),
  GetPage(name: LoginScreen.routeName, page: () => const LoginScreen()),
  GetPage(name: SignupScreen.routeName, page: () => const SignupScreen()),
  GetPage(name: AddAddressScreen.routeName, page: () => AddAddressScreen()),
  GetPage(name: PostAddressPage.routeName, page: () => const PostAddressPage()),
  GetPage(name: MapScreen.routeName, page: () => const MapScreen()),
  GetPage(
      name: TabScreen.routeName,
      page: () => const TabScreen(),
      binding: StoreBinding()),
  GetPage(name: SearchScreen.routeName, page: () => const SearchScreen()),
  GetPage(name: FruitScreen.routeName, page: () => const FruitScreen()),
  GetPage(name: CategoryScreen.routeName, page: () => const CategoryScreen()),
  GetPage(name: Notification.routeName, page: () => const Notification()),
  GetPage(
      name: PoductsListScreen.routeName, page: () => const PoductsListScreen()),
  GetPage(name: SelectTime.routeName, page: () => SelectTime()),
  GetPage(
      name: SpecialDealScreen.routeName, page: () => const SpecialDealScreen()),
  GetPage(
      name: SearchFruitScreen.routeName, page: () => const SearchFruitScreen()),
  GetPage(
      name: ProductDetailScreen.routeName,
      page: () => const ProductDetailScreen()),
  GetPage(
      name: OrderSummaryScreen.routeName,
      page: () => const OrderSummaryScreen()),
  GetPage(name: CheckoutScreen.routeName, page: () => const CheckoutScreen()),
  GetPage(
      name: OrderSuccessScreen.routeName,
      page: () => const OrderSuccessScreen()),
  GetPage(name: MyProfileScreen.routeName, page: () => MyProfileScreen()),
  GetPage(name: OtpScreen.routeName, page: () => const OtpScreen()),
  GetPage(name: MyOrders.routeName, page: () => const MyOrders()),
  GetPage(name: CartScreen.routeName, page: () => const CartScreen()),
  GetPage(name: PaymentScreen.routeName, page: () => const PaymentScreen()),
  //GetPage(name: FlutterPayUPI.routeName, page: () => FlutterPayUPI()),
  GetPage(
      name: SelectPaymentMethod.routeName, page: () => SelectPaymentMethod()),
  GetPage(name: SignUpSuccess.routeName, page: () => const SignUpSuccess()),

  GetPage(name: SignUpWait.routeName, page: () => const SignUpWait())

  // MyOrders.routeName: (ctx) => const MyOrders(),
];
