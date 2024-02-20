import 'package:intl/intl.dart';

String convertTimestampToDateString(String? timestampString) {
  // Parse the timestamp string to a DateTime object
  DateTime dateTime = DateTime.parse(timestampString ?? "2024-02-19T06:28:57.510795Z");

  // Format the DateTime object as dd/mm/yy
  String formattedDate = DateFormat('dd/MM/yy').format(dateTime);

  return formattedDate;
}

String convertDoubleToString(String value){
  double d = double.parse(value);
  int i = d.toInt();
  String s = i.toString();
  return s;
}