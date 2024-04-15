// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:sutra_ecommerce/utils/generic_exception.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

import 'internet_error.dart';

class NetworkDioHttp {
  static Box? box;
  static Dio? _dio;
  static String? endPointUrl;
  static Options? _cacheOptions;
  static DioCacheManager? _dioCacheManager;
  static InternetError internetError = InternetError();
  static NetworkRepository networkRepository = NetworkRepository();

  static Future<Map<String, String>> getHeaders() async {
    final String? token = box?.get('token');
    log("Token :- $token");
    if (token != null) {
      debugPrint(
          '~~~~~~~~~~~~~~~~~~~~ SET HEADER : $token ~~~~~~~~~~~~~~~~~~~');
      return {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'authorization': token,
      };
    } else {
      return {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
    }
  }

  static setDynamicHeader({@required String? endPoint}) async {
    endPointUrl = endPoint;
    BaseOptions options = BaseOptions(
      receiveTimeout: 15000,
      connectTimeout: 15000,
    );

    _dioCacheManager = DioCacheManager(CacheConfig());
    final token = await getHeaders();
    log(token.toString());
    options.headers.addAll(token);
    _dio = Dio(options);
    _dio!.interceptors.add(_dioCacheManager!.interceptor);
    if (kDebugMode) {
      //_dio!.interceptors.add(ChuckerDioInterceptor());
    }
  }

  static setDynamicHeaderWeb({@required String? endPoint}) async {
    endPointUrl = endPoint;
    BaseOptions options = BaseOptions(
      receiveTimeout: 15000,
      connectTimeout: 15000,
    );

    final token = await getHeaders();
    options.headers.addAll(token);
    _dio = Dio(options);

    if (kDebugMode) {
      //_dio!.interceptors.add(ChuckerDioInterceptor());
    }
  }

  //Get Method
  static Future<Map<String, dynamic>> getDioHttpMethod({
    bool? loadingShow,
    required String url,
    final header,
  }) async {
    var internet = await check();
    if (internet) {
      if (loadingShow == null) null;

      try {
        debugPrint(url);
        Response response = await _dio!
            .get(url, options: header ?? _cacheOptions);
   /*         .onError((error, stackTrace) {
          throw error.toString();
        });*/

        log(response.toString());

        // ignore: prefer_typing_uninitialized_variables
        var responseBody;
        if (response.statusCode == 200) {
          try {
            Map<String, dynamic> responseBody = json.decode(response.data);
          } catch (error) {
            responseBody = response.data;
          }
          Map<String, dynamic> data = {
            'body': responseBody,
            'headers': response.headers,
            'error_description': null,
          };
          //

          return data;
        }
        else if (response.statusCode == 500) {
          return {
            'body': "Something Went Wrong",
            'headers': null,
            'error_description': "Something Went Wrong",
          };
        }
        else {
          if (response.statusCode == 500) {
            // Handle 500 status code error here
            return {
              'body': "Something Went Wrong",
              'headers': null,
              'error_description': "Server Error",
            };
          }
          //

          return {
            'body': "Something Went Wrong",
            'headers': null,
            'error_description': "Something Went Wrong",
          };
        }
      } on DioError catch (e) {
        print('DioError::: $e');

        if (e.response != null) {
          print("status code in get api ${e.response?.statusCode}");
          print("message in get api ${e.response?.statusMessage}");
          print(e.response?.requestOptions);
          throw AppException(
            error: e,
            type: ErrorType.dioError,
            statusCode: e.response?.statusCode,
             res:  e.response
          );
        }
        else {
          // Something happened in setting up or sending the request that triggered an Error
          print(e.requestOptions);
          print("aswswdasd${e.message}");
        }

        return Future.error(e.response?.data);
      }
   /*   catch (error, stacktrace) {
        print('stacktrace::: $error');
        throw AppException(
          error: error,
          type: ErrorType.dioError,
        );
      }*/
    } else {
      Map<String, dynamic> responseData = {
        'body': null,
        'headers': null,
        'error_description': "Internet Error",
      };
      internetError.addOverlayEntry();
      return responseData;
      // func(false);
    }
  }

  //Put Method

  static Future<Map<String, dynamic>> putDioHttpMethod({
    required String url,
    required data,
    final header,
  }) async {
    var internet = await check();
    if (internet) {
      null;
      try {
        Response response =
            await _dio!.put(url, data: data, options: header ?? _cacheOptions);
        if (kDebugMode) {
          log(response.toString());
        }

        // ignore: prefer_typing_uninitialized_variables
        var responseBody;
        if (response.statusCode == 200) {
          try {
            responseBody = json.decode(json.encode(response.data));
          } catch (e) {
            responseBody = response.data;
            debugPrint('catch...');
          }

          return {
            'body': responseBody,
            'headers': response.headers,
            'error_description': null,
          };
        } else if (response.statusCode == 500) {
          return {
            'body': "Server Error",
            'headers': null,
            'error_description': "Something Went Wrong",
          };
        } else {
          return {
            'body': null,
            'headers': null,
            'error_description': "Something Went Wrong",
          };
        }
      } on DioError catch (e) {
        if (e.response!.statusCode == 500) {
          // Handle 500 status code error here
          return {
            'body': e.response!.data,
            'headers': null,
            'error_description': "Server Error",
          };
        }
        Map<String, dynamic> responseData = {
          'body': e.response?.data,
          'headers': null,
          'error_description':
              await _handleError(e, message: e.response?.data['message']),
        };

        return responseData;
      }
    } else {
      Map<String, dynamic> responseData = {
        'body': null,
        'headers': null,
        'error_description': "Internet Error",
      };

      internetError.addOverlayEntry();
      return responseData;
      // func(false);
    }
  }

  static Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  //Post Method
  static Future<Map<String, dynamic>> postDioHttpMethod({
    required String url,
    required data,
    final header,
  }) async {
    var internet = await check();
    if (internet) {
      null;
      Response? response;
      try {
        debugPrint("URL :$url");
        response = await _dio!.post(
          url,
          data: data,
          options: header ?? _cacheOptions,
        );

        log(response.toString());
        // ignore: prefer_typing_uninitialized_variables
        var responseBody;
        if (response.statusCode == 200 || response.statusCode == 201) {
          //

          try {
            responseBody = json.decode(json.encode(response.data));
          } catch (error) {
            debugPrint('decode error');
            responseBody = response.data;
          }
          return {
            'body': responseBody,
            'headers': response.headers,
            'error_description': null,
          };
        } else {
          if (response.statusCode == 500) {
            // Handle 500 status code error here
            return {
              'body': "Server Error",
              'headers': null,
              'error_description': "Server Error",
            };
          }

          Fluttertoast.showToast(msg: "${response.data}");
          return response.data;
        }
      } on DioError catch (e) {
        if (e.response!.statusCode == 500) {
          // Handle 500 status code error here
          return {
            'body': "Server Error",
            'headers': null,
            'error_description': "Server Error",
          };
        }

        log(e.error.toString());
        log(e.message.toString());
        log(e.response!.statusMessage.toString());
        log(e.response!.statusCode.toString());
        // log(e.message.toString());
        Map<String, dynamic> responseData = {
          'body': e.response?.data,
          'headers': null,
          'error_description': e.response != null
              ? e.response?.data['detail'] != null
                  ? await _handleError(e, message: e.response?.data['detail'])
                  : await _handleError(e, message: e.response?.data['error'])
              : ""
          // await _handleError(e, message: e.response?.data['detail']),
        };

        return Future.error(responseData);
      } catch (e) {
        log(e.toString());
        return Future.error(e);
      }
    } else {
      Map<String, dynamic> responseData = {
        'body': null,
        'headers': null,
        'error_description': "Internet Error",
      };
      internetError.addOverlayEntry();

      return responseData;
    }
  }

  //Delete Method
  static Future<Map<String, dynamic>> deleteDioHttpMethod(
      {required String url, data}) async {
    var internet = await check();
    if (internet) {
      null;
      try {
        debugPrint(data);
        debugPrint("URL :$url");
        Response response = await _dio!.delete(
          url,
          data: data,
          options: _cacheOptions,
        );
        // ignore: prefer_typing_uninitialized_variables
        var responseBody;

        if (response.statusCode == 200) {
          try {
            responseBody = json.decode(json.encode(response.data));
          } catch (error) {
            debugPrint('decode error');
            responseBody = response.data;
          }
          return {
            'body': responseBody,
            'headers': response.headers,
            'error_description': null,
          };
        } else if (response.statusCode == 500) {
          return {
            'body': "Something Went Wrong",
            'headers': null,
            'error_description': "Something Went Wrong",
          };
        } else {
          return {
            'body': null,
            'headers': null,
            'error_description': "Something Went Wrong",
          };
        }
      } on DioError catch (e) {
        Map<String, dynamic> responseData = {
          'body': null,
          'headers': null,
          'error_description':
              await _handleError(e, message: e.response?.data['message']),
        };

        return responseData;
      }
    } else {
      Map<String, dynamic> responseData = {
        'body': null,
        'headers': null,
        'error_description': "Internet Error",
      };
      internetError.addOverlayEntry();
      return responseData;
      // func(false);
    }
  }

  // //Multiple Concurrent
  static Future<Map<String, dynamic>> multipleConcurrentDioHttpMethod(
      {required String getUrl,
      required String postUrl,
      required Map<String, dynamic> postData}) async {
    try {
      null;
      List<Response> response = await Future.wait([
        _dio!.post("$endPointUrl/$postUrl",
            data: postData, options: _cacheOptions),
        _dio!.get("$endPointUrl/$getUrl", options: _cacheOptions)
      ]);
      if (response[0].statusCode == 200 || response[0].statusCode == 200) {
        if (response[0].statusCode == 200 && response[1].statusCode != 200) {
          return {
            'getBody': null,
            'postBody': json.decode(response[0].data),
            'headers': response[0].headers,
            'error_description': null,
          };
        } else if (response[1].statusCode == 200 &&
            response[0].statusCode != 200) {
          return {
            'getBody': null,
            'postBody': json.decode(response[0].data),
            'headers': response[0].headers,
            'error_description': null,
          };
        } else {
          return {
            'postBody': json.decode(response[0].data),
            'getBody': json.decode(response[0].data),
            'headers': response[0].headers,
            'error_description': null,
          };
        }
      } else if (response[0].statusCode == 500) {
        return {
          'body': "Something Went Wrong",
          'headers': null,
          'error_description': "Something Went Wrong",
        };
      } else {
        return {
          'postBody': null,
          'getBody': null,
          'headers': null,
          'error_description': "Something Went Wrong",
        };
      }
    } catch (e) {
      Map<String, dynamic> responseData = {
        'postBody': null,
        'getBody': null,
        'headers': null,
        'error_description': await _handleError(e),
      };

      return responseData;
    }
  }

  //Sending FormData
  static Future<Map<String, dynamic>> sendingFormDataDioHttpMethod(
      {required String url, required Map<String, dynamic> data}) async {
    var internet = await check();
    if (internet) {
      try {
        null;
        FormData formData = FormData.fromMap(data);
        Response response = await _dio!
            .post("$endPointUrl$url", data: formData, options: _cacheOptions);
        if (response.statusCode == 200) {
          return {
            'body': json.decode(response.data),
            'headers': response.headers,
            'error_description': null,
          };
        } else if (response.statusCode == 500) {
          return {
            'body': "Something Went Wrong",
            'headers': null,
            'error_description': "Something Went Wrong",
          };
        } else {
          return {
            'body': null,
            'headers': null,
            'error_description': "Something Went Wrong",
          };
        }
      } catch (e) {
        Map<String, dynamic> responseData = {
          'body': null,
          'headers': null,
          'error_description': await _handleError(e),
        };

        return responseData;
      }
    } else {
      Map<String, dynamic> responseData = {
        'body': null,
        'headers': null,
        'error_description': "Internet Error",
      };
      internetError.addOverlayEntry();
      return responseData;
    }
  }

  // Handle Error
  static Future<String> _handleError(error, {message}) async {
    String errorDescription = "";
    try {
      debugPrint("In side try");
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        debugPrint("In side internet condition");
        if (error is DioError) {
          // ignore: unnecessary_cast
          DioError dioError = error as DioError;
          switch (dioError.type) {
            case DioErrorType.connectTimeout:
              errorDescription = "Connection timeout with API server";
              debugPrint(errorDescription);
              break;
            case DioErrorType.sendTimeout:
              errorDescription = "Send timeout in connection with API server";
              debugPrint(errorDescription);
              break;
            case DioErrorType.receiveTimeout:
              errorDescription =
                  "Receive timeout in connection with API server";
              debugPrint(errorDescription);
              break;
            case DioErrorType.response:
              errorDescription = message;
              debugPrint(errorDescription);
              break;
            case DioErrorType.cancel:
              errorDescription = "Request to API server was cancelled";
              debugPrint(errorDescription);
              break;
            case DioErrorType.other:
              errorDescription =
                  "Connection to API server failed due to internet connection";
              debugPrint(errorDescription);
              break;
          }
        } else {
          errorDescription = 'Unexpected ErrorOccurred';
          debugPrint(errorDescription);
        }
      }
    } on SocketException catch (_) {
      errorDescription = 'Check Connection';
      debugPrint(errorDescription);
    }

    return errorDescription;
  }
}
