import 'package:intl/intl.dart';

String convertTimestampToDateString(String timestampString) {
  // Parse the timestamp string to a DateTime object
  DateTime dateTime = DateTime.parse(timestampString);

  // Format the DateTime object as dd/mm/yy
  String formattedDate = DateFormat('dd/MM/yy').format(dateTime);

  return formattedDate;
}