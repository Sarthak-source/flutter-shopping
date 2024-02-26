import 'package:intl/intl.dart';

String convertTimestampToDateString(String? timestampString) {
  // Parse the timestamp string to a DateTime object
  DateTime dateTime = DateTime.parse(timestampString ?? "2024-02-19T06:28:57.510795Z");

  // Format the DateTime object as dd/mm/yy
  String formattedDate = DateFormat('dd/MM/yy').format(dateTime);

  return formattedDate;
}

String convertDoubleToString(String value){
  String s = "";
  if(value != "null"){
    double d = double.parse(value);
    int i = d.toInt();
     s = i.toString();
  }

  return s;
}

String titleCase(String text) {
  if (text.length <= 1) return text.toUpperCase();
  var words = text.split(' ');
  var capitalized = words.map((word) {
    var first = word.substring(0, 1).toUpperCase();
    var rest = word.substring(1);
    return '$first$rest';
  });
  return capitalized.join(' ');
}