// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:developer';

//import 'package:geolocator/geolocator.dart';
// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sutra_ecommerce/config/common.dart';
import 'package:sutra_ecommerce/utils/api_constants.dart';
import 'package:sutra_ecommerce/utils/network_dio.dart';

NetworkRepository networkRepository = NetworkRepository();

class NetworkRepository {
  static final NetworkRepository _networkRepository =
      NetworkRepository._internal();
  factory NetworkRepository() {
    return _networkRepository;
  }
  NetworkRepository._internal();

  FocusNode searchFocus = FocusNode();
  // static Dio? _dio;

  // Future ipChange() async {
  //   try {
  //     final apiResponse = await NetworkDioHttp.getDioHttpMethod(
  //       url: "http://192.46.215.236/api/get_ip_address/",
  //       // data: {"name": name, "password": password, "phone_number": number},
  //       // header: Options(headers: <String, String>{'authorization': auth}),
  //     );
  //     debugPrint('\x1b[97m Response : ${apiResponse['body']['ip_address']}');
  //     box!.put("ip", "${apiResponse['body']['ip_address']}");
  //     log(box!.get("ip"));
  //     // return await apiResponse['body'];
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: e.toString(), backgroundColor: Colors.red);
  //     return e.toString();
  //   }
  // }

  Future userSignup(
      {required String name,
      required String password,
      required String number}) async {
    try {
      final apiResponse = await NetworkDioHttp.postDioHttpMethod(
        url: "${ApiAppConstants.apiEndPoint}${ApiAppConstants.signup}",
        data: {"name": name, "password": password, "phone_number": number},
        header: Options(headers: <String, String>{'authorization': auth}),
      );
      debugPrint('\x1b[97m Response : $apiResponse');

      return await apiResponse['body'];
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), backgroundColor: Colors.red);
      return e.toString();
    }
  }

  Future userLogin({required String number}) async {
    try {
      final apiResponse = await NetworkDioHttp.postDioHttpMethod(
        url: "${ApiAppConstants.apiEndPoint}${ApiAppConstants.otp}",
        data: {"mobile_number": number},
        header: Options(headers: <String, String>{'authorization': auth}),
      );
      debugPrint('\x1b[97m Response : $apiResponse');
      return await apiResponse['body'];
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), backgroundColor: Colors.red);
      return e.toString();
    }
  }

  Future verifyLogin({required String number, required String otp}) async {
    try {
      final apiResponse = await NetworkDioHttp.postDioHttpMethod(
        url: "${ApiAppConstants.apiEndPoint}${ApiAppConstants.verifyOTP}",
        data: {"mobile_number": number, "otp": otp},
        header: Options(headers: <String, String>{'authorization': auth}),
      );
      debugPrint('\x1b[97m Response : $apiResponse');
      return await apiResponse['body'];
    } catch (e) {
      // CommonMethod().getXSnackBar("Error", e.toString(), Colors.red);
      Fluttertoast.showToast(msg: "Wrong OTP", backgroundColor: Colors.red);
      return e.toString();
    }
  }

  Future checkUser({required String number}) async {
    log("${ApiAppConstants.apiEndPoint}${ApiAppConstants.checkParty}?username=$number");
    try {
      final apiResponse = await NetworkDioHttp.getDioHttpMethod(
        url:
            "${ApiAppConstants.apiEndPoint}${ApiAppConstants.checkParty}?username=$number",
        header: Options(headers: <String, String>{'authorization': auth}),
      );

      debugPrint('\x1b[97m checkSeller Response : $apiResponse');

      final body = apiResponse['body'];

      if (body.isEmpty &&
          body['error'] != null &&
          body['error'] == 'User not exist please sign up') {
        Fluttertoast.showToast(msg: body['error'].toString());
      }

      return apiResponse;
    } catch (e) {
      dynamic er = e;
      //Fluttertoast.showToast(msg: er['body']['error']);

      return er.toString();
    }
  }

  static Future getCategories({required String level, String? parent}) async {
    try {
      final apiResponse = await NetworkDioHttp.getDioHttpMethod(
        url:
            "${ApiAppConstants.apiEndPoint}${ApiAppConstants.productCategories}?level=$level&parent=$parent",
        header: Options(headers: <String, String>{'authorization': auth}),
      );

      debugPrint('\x1b[97m checkSeller Response : $apiResponse');

      final body = apiResponse['body'];

      if (body != null &&
          body['error'] != null &&
          body['error'] == 'User not exist please sign up') {
        Fluttertoast.showToast(msg: body['error'].toString());
      }

      return apiResponse;
    } catch (e) {
      dynamic er = e;
      //Fluttertoast.showToast(msg: er['body']['error']);

      return er.toString();
    }
  }

  static Future getMyCart({required String party}) async {
    try {
      final apiResponse = await NetworkDioHttp.getDioHttpMethod(
        url:
            "${ApiAppConstants.apiEndPoint}${ApiAppConstants.mycart}?party=$party",
        header: Options(headers: <String, String>{'authorization': auth}),
      );
      log('mycartItems in repo++++$apiResponse');
      print('authorization $auth');
      debugPrint('\x1b[97m mycart Response : $apiResponse');

      final body = apiResponse['body'];

      if (body != null &&
          body['error'] != null &&
          body['error'] == 'User not exist please sign up') {
        Fluttertoast.showToast(msg: body['error'].toString());
      }

      return apiResponse;
    } catch (e) {
      dynamic er = e;
      //Fluttertoast.showToast(msg: er['body']['error']);

      return er.toString();
    }
  }


  static Future getMyOrders({
    required String party,
    required String order_prifix,
    required String order_status,
    required String order_date,
    required String delivery_required_on,
  }) async {
    try {
      final apiResponse = await NetworkDioHttp.getDioHttpMethod(
        url:
        "${ApiAppConstants.apiEndPoint}${ApiAppConstants.myOrders}?party=$party&order_prifix=&order_status=$order_status&order_date=&delivery_required_on=",
        header: Options(headers: <String, String>{'authorization': auth}),
      );
      log('myOrders in repo++++$apiResponse');
      debugPrint('\x1b[97m myOrders Response : $apiResponse');

      final body = apiResponse['body'];

      if (body != null &&
          body['error'] != null &&
          body['error'] == 'User not exist please sign up') {
        Fluttertoast.showToast(msg: body['error'].toString());
      }

      return apiResponse;
    } catch (e) {
      dynamic er = e;
      //Fluttertoast.showToast(msg: er['body']['error']);

      return er.toString();
    }
  }


  static Future getOrderDetail({
    required String orderId,

  }) async {
    try {
      final apiResponse = await NetworkDioHttp.getDioHttpMethod(
        url:
        "${ApiAppConstants.apiEndPoint}${ApiAppConstants.myOrderDetail}$orderId",
        header: Options(headers: <String, String>{'authorization': auth}),
      );
      log('myOrderDetail in repo++++$apiResponse');
      debugPrint(' myOrderDetail Response : $apiResponse');

      final body = apiResponse['body'];

      if (body != null &&
          body['error'] != null &&
          body['error'] == 'User not exist please sign up') {
        Fluttertoast.showToast(msg: body['error'].toString());
      }

      return apiResponse;
    } catch (e) {
      dynamic er = e;
      //Fluttertoast.showToast(msg: er['body']['error']);

      return er.toString();
    }
  }

  static Future getMyAddress({required String party}) async {
    try {
      final apiResponse = await NetworkDioHttp.getDioHttpMethod(
        url:
            "${ApiAppConstants.apiEndPoint}${ApiAppConstants.myaddress}?party=$party",
        header: Options(headers: <String, String>{'authorization': auth}),
      );
      log('myaddress in repo++++$apiResponse');
      debugPrint('\x1b[97m myaddress Response : $apiResponse');

      final body = apiResponse['body'];

      if (body != null &&
          body['error'] != null &&
          body['error'] == 'User not exist please sign up') {
        Fluttertoast.showToast(msg: body['error'].toString());
      }

      return apiResponse;
    } catch (e) {
      dynamic er = e;
      //Fluttertoast.showToast(msg: er['body']['error']);

      return er.toString();
    }
  }

  static getProducts(
      {String? category,
      String? status,
      String? search,
      String? partyId,
      String? page}) async {
    try {
      final apiResponse = await NetworkDioHttp.getDioHttpMethod(
        url:
            "${ApiAppConstants.apiEndPoint}${ApiAppConstants.products}?category=$category&status=$status&search=$search&party=$partyId&page=$page",
        header: Options(headers: <String, String>{'authorization': auth}),
      );

      debugPrint('\x1b[97m checkSeller Response : $apiResponse');

      final body = apiResponse['body'];

      if (body != null &&
          body['error'] != null &&
          body['error'] == 'User not exist please sign up') {
        Fluttertoast.showToast(msg: body['error'].toString());
      }

      return apiResponse;
    } catch (e) {
      dynamic er = e;
      Fluttertoast.showToast(msg: er['body']['error']);

      return er['body']['error'].toString();
    }
  }

// shipping from
  Future addressListPost(
      {required String name,
      required String gstin,
      required String pin,
      required String address,
      required String location}) async {
    try {
      var data = FormData.fromMap({
        "trader": "${box!.get("sellerID")}",
        "name": name,
        "gstin": gstin,
        "pin": pin,
        "address": address,
        "location": location,
      });
      log(data.fields.toString());
      final apiResponse = await NetworkDioHttp.postDioHttpMethod(
        url: "${ApiAppConstants.apiEndPoint}${ApiAppConstants.addressListPost}",
        header: Options(headers: <String, String>{'authorization': auth}),
        data: data,
      );
      debugPrint('\x1b[97m  addressListPost  Response : $apiResponse');
      return await apiResponse['body'];
    } catch (e) {
      dynamic details = e;
      log(e.toString());
      Fluttertoast.showToast(msg: details["body"]["detail"].toString());
      rethrow;
    }
  }

  static Future addToCart({
    required String count,
    required String product,
    required String party,
  }) async {
    try {
      var data = FormData.fromMap({
        "count": count,
        "product": product,
        "party": party,
      });
      log("dataposted $data");
      final apiResponse = await NetworkDioHttp.postDioHttpMethod(
        url: "${ApiAppConstants.apiEndPoint}${ApiAppConstants.addToCart}",
        header: Options(headers: <String, String>{'authorization': auth}),
        data: data,
      );
      debugPrint('\x1b[97m  addressListPost  Response : $apiResponse');
      return await apiResponse['body'];
    } catch (e) {
      dynamic details = e;
      log(e.toString());
      Fluttertoast.showToast(msg: details["body"]["detail"].toString());
      rethrow;
    }
  }

  static Future CreateOrderApi({
    required String shift,
    required String deliverydate,
    required String party,
    required String address,
  }) async {
    try {
      var data = FormData.fromMap({
        "party": party,
        "shift": shift,
        "delivery_required_on": deliverydate,
        "address": address,
      });
      log("dataposted $data");
      final apiResponse = await NetworkDioHttp.postDioHttpMethod(
        url:
            "${ApiAppConstants.apiEndPoint}${ApiAppConstants.createorderapi}?party=$party",
        header: Options(headers: <String, String>{'authorization': auth}),
        data: data,
      );
      debugPrint('\x1b[97m  Createorderapi  Response : $apiResponse');

/*      final body = apiResponse['body'];

      if (body != null &&
          body['error'] != null) {
        Fluttertoast.showToast(msg: body['error'].toString());
      }*/

      return apiResponse;
    } catch (e) {
      dynamic details = e;
      log(e.toString());
      Fluttertoast.showToast(msg: details["body"]["detail"].toString());
      rethrow;
    }
  }

  static Future UpdateCart({
    required String count,
    required String cart,
    required String type,
    required String party,
  }) async {
    try {
      var data;
      if(type == "delete"){
         data = FormData.fromMap({
          "count": count,
          "cart": cart,
          "type": type,
        });
      }else{
         data = FormData.fromMap({
          "count": count,
          "cart": cart,
          "type": type,
        });
      }

      log("dataposted $data");
      final apiResponse = await NetworkDioHttp.putDioHttpMethod(
        url:
            "${ApiAppConstants.apiEndPoint}${ApiAppConstants.updatecart}?party=$party",
        header: Options(headers: <String, String>{'authorization': auth}),
        data: data,
      );
      debugPrint('\x1b[97m  updatecart  Response : $apiResponse');
      log('apiResponsebody in repo ${apiResponse['body']}');
      final body = apiResponse['body'];

      if (body != null &&
          body['error'] != null &&
          body['error'] == 'User not exist please sign up') {
        Fluttertoast.showToast(msg: body['error'].toString());
      }

      return apiResponse;

      // return  await apiResponse['body'];
    } catch (e) {
      dynamic details = e;
      log(e.toString());
      Fluttertoast.showToast(msg: details["body"]["detail"].toString());
      rethrow;
    }
  }

  static Future addNewAddress({
    required String add1,
    required String add2,
    required String add3,
    required String pincode,
    required String gst,
  }) async {
    try {
      Map storedUserData=box!.get('userData');
      var data = FormData.fromMap({
        "party": storedUserData['party']['id'].toString(),
        "gstin": gst,
        "address_line1": add1,
        "is_active": "yes",
        "address_line2": add3,
        "address_line3": add3,
        "pin_code": pincode,
      });
      log("addNewAddress data:: $data");
      final apiResponse = await NetworkDioHttp.postDioHttpMethod(
        url: "${ApiAppConstants.apiEndPoint}${ApiAppConstants.postaddress}",
        header: Options(headers: <String, String>{'authorization': auth}),
        data: data,
      );
      debugPrint('\x1b[97m  postaddress  Response : $apiResponse');
      final body = apiResponse['body'];

      if (body != null &&
          body['error'] != null &&
          body['error'] == 'User not exist please sign up') {
        Fluttertoast.showToast(msg: body['error'].toString());
      }

      return apiResponse;
    } catch (e) {
      dynamic details = e;
      log(e.toString());
      Fluttertoast.showToast(msg: details["body"]["detail"].toString());
      rethrow;
    }
  }


  static Future getDeals() async {
    try {
      final apiResponse = await NetworkDioHttp.getDioHttpMethod(
        url:
            "${ApiAppConstants.apiEndPoint}${ApiAppConstants.deals}?is_active=Active",
        header: Options(headers: <String, String>{'authorization': auth}),
      );
      log('mycartItems in repo++++$apiResponse');
      debugPrint('\x1b[97m mycart Response : $apiResponse');

      final body = apiResponse['body'];

      if (body != null &&
          body['error'] != null &&
          body['error'] == 'User not exist please sign up') {
        Fluttertoast.showToast(msg: body['error'].toString());
      }

      return apiResponse;
    } catch (e) {
      dynamic er = e;
      //Fluttertoast.showToast(msg: er['body']['error']);

      return er.toString();
    }
  }

// shipping from
}
