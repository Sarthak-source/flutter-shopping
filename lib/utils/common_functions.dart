import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../exceptions/data_exceptions.dart';
import 'generic_exception.dart';

String convertTimestampToDateString(String? timestampString) {
  if (timestampString == null) {
    return ''; // Return an empty string for null values
  }

  try {
    // Parse the timestamp string to a DateTime object
    DateTime dateTime = DateTime.parse(timestampString);

    // Format the DateTime object as dd/mm/yy
    String formattedDate = DateFormat('dd/MM/yy').format(dateTime);
    if (kDebugMode) {
      print('valid date format: $timestampString');
    }
    return formattedDate;
  } catch (e) {
    if (kDebugMode) {
      print('Invalid date format: $timestampString');
    }
    return ''; // Return an empty string if the date format is invalid
  }
}

String convertTimestampToDateString2(String? timestampString) {
  if (timestampString == null) {
    return ''; // Return an empty string for null values
  }

  try {
    // Parse the timestamp string to a DateTime object
    DateTime dateTime = DateTime.parse(timestampString);

    // Format the DateTime object as dd/mm/yy
    String formattedDate = DateFormat('dd-MMM-yy').format(dateTime);
    if (kDebugMode) {
      print('valid date format: $timestampString');
    }
    return formattedDate;
  } catch (e) {
    if (kDebugMode) {
      print('Invalid date format: $timestampString');
    }
    return ''; // Return an empty string if the date format is invalid
  }
}

String convertDoubleToString(String? value) {
  if (value == null || value == "null") {
    // Handle null or "null" input values
    return "0.0";
  }
  try {
    double d = double.parse(value);
    int i = d.toInt();
    return i.toString();
  } catch (e) {
    // Handle parsing errors gracefully
    return "0.0";
  }
}

String titleCase(String? text) {
  if (text != null && text != 'null') {
    if (text.length <= 1) return text.toUpperCase();
    var words = text.split(' ');
    var capitalized = words.map((word) {
      var first = word.substring(0, 1).toUpperCase();
      var rest = word.substring(1);
      return '$first$rest';
    });
    return capitalized.join(' ');
  } else {
    return '';
  }
}

String errorHandler(AppException appException) {
  var errorMsg = '';
  if (appException.error is String) {
    //Something went wrong error
    errorMsg = appException.error as String;
  } else if (appException.type == ErrorType.dioError) {
    //Dio code error
    var dioError = appException.error as DioError;
    errorMsg = DataException.errorResponseHandler(dioError);
  } else {
    //Status code error
    errorMsg = DataException.handleError(appException.statusCode!);
  }
  if (kDebugMode) {
    print('errorMsg:: $errorMsg');
  }
  return errorMsg;
}

twodecimalDigit(double? v) {
  double? value = v ?? 0.000;
  String formattedValue = value
      .toStringAsFixed(2); // This will format the value to two decimal places
  if (kDebugMode) {
    print("Decimal :: $formattedValue");
  } // Output will be "123.46"
  return formattedValue;
}
