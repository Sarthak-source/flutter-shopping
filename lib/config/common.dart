import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

Color teal = Colors.teal;
Color white = Colors.white;
Color black = Colors.black;
Color grey = Colors.grey;
Color blueGrey = Colors.blueGrey;

Color blue = Colors.blue;
Color red = Colors.red;
Color green = Colors.green;
Color orange = Colors.orange;

Box? box;
Box? localBox;
height(double height) => SizedBox(height: height);
width(double width) => SizedBox(width: width);

// dateFormat() => DateFormat('dd MMM y h:mm a');
dateFormat() => DateFormat("dd MMM y");
timeFormat() => DateFormat('hh:mm a');
dateMonthFormat() => DateFormat('dd MMM ');

//PackageInfo? packageInfo;

List roles = box!.containsKey("seller_role") ? box!.get("seller_role") : [];

NumberFormat numberFormat = NumberFormat.decimalPattern('hi');

//FirebaseMessaging messaging = FirebaseMessaging.instance;

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey(debugLabel: "Main Navigator");

extension ExtOnNum on num {
  format() {
    final parts = toString().split('.');
    return parts[1].length == 1
        ? '${numberFormat.format(num.tryParse(parts[0]) ?? 0.0)}.${parts[1]}0'
        : '${numberFormat.format(num.tryParse(parts[0]) ?? 0.0)}.${parts[1]}';
  }
}

extension ExtOnNum2 on num {
  String format2() {
    final parts = toString().split('.');
    if (parts.length == 1) {
      return '${numberFormat.format(this)}.00';
    } else if (parts[1].length == 1) {
      return '${numberFormat.format(num.tryParse(parts[0]) ?? 0.0)}.${parts[1]}0';
    } else {
      return '${numberFormat.format(num.tryParse(parts[0]) ?? 0.0)}.${parts[1]}';
    }
  }
}
