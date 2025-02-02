import 'dart:convert';

import 'package:sutra_ecommerce/config/common.dart';

var auth = 'Basic ${base64Encode(utf8.encode('gfg:gfgtech123'))}'; // Prod

// var auth = 'Basic ${base64Encode(utf8.encode('gfg:!gfgtech123#'))}';  // Dev
// var ip = '139.162.12.150'; // Prod
// var ip = '172.105.55.52'; // new server
// var ip = '192.46.215.236'; // Dev
// var ip = box!.get("ip"); // temporary
var ip = box!.containsKey("isTestEnvironment")
    ? box!.get('isTestEnvironment')
        ? '192.168.1.27:8000'
        : '192.168.1.27:8000'
    : '192.168.1.27:8000';

var local = '192.168.213.132:8000';

//http://192.168.1.27:8000/api/check_party/?username=9844398489

class ApiAppConstants {
  // static String apiEndPoint = "http://139.162.12.150/api/";
  //static String apiEndPoint = "http://170.187.232.148/api/";// Prod
  static String apiEndPoint = "http://170.187.232.148/api/";
  //static String apiEndPoint = "http://192.168.1.23:8000/api/";

  static const String signup = 'new_party/';
  static const String partyUpdate = 'party_update/';
  static const String otp = 'sendLoginOTP/';
  static const String resendOTP = 'resendLogiOTP/';
  static const String verifyOTP = 'verifyLoginOTP/';
  static const String checkParty = 'check_party/';
  static const String partyConfig = 'party_config/';
  static const String productCategories = 'product/product_categories/';
  static const String products = 'products/';
  static const String exploreProducts = 'explore_products/';
  static const String addToCart = 'add_cart/';
  static const String mycart = 'cart';
  static const String myaddress = 'inventory/address_list/';
  static const String deals = 'product/deals/';
  static const String updatecart = 'update_cart/';
  static const String createorderapi = 'create_order/';
  static const String reorderapi = 'reorder/';

  static const String invoices = 'invoices/';
  static const String payment = 'payment/payment/';
  static const String pendingpayment = 'party_pending_amount/';
  static const String addPayment = 'payment/payment/';

  static const String exploreCategories = 'explore_categories/';

  static const String myOrders = 'orders/';
  static const String myOrderDetail = 'order_detail/';
  static const String postaddress = 'inventory/address_post/';
  static const String getstates = 'inventory/state/';
  static const String addressListPost = 'addressListPost/';
  static const String invoicePayments = 'invoice_payments/';
  static const String updateInvoicePayments = 'invoice_update_payments/';
}
