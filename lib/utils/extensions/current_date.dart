import 'package:intl/intl.dart';

currentDateTime() {
  DateTime now = DateTime.now();

  // Create a DateFormat instance
  DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');

  // Format the DateTime
  String formattedDateTime = formatter.format(now);
  return formattedDateTime;
}
