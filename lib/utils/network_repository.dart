// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:developer';

//import 'package:geolocator/geolocator.dart';
// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:fluttertoast/fluttertoast.dart';
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

  static getProducts({String? category, String? status, String? search, String? partyId,String? page}) async {
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

// shipping from
}
