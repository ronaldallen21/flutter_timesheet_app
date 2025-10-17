import 'package:intl/intl.dart';

// Format Date as YYYY-MM-DD
String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(date);
}

// Format Time as HH:MM AM/PM
String formatTime(DateTime time) {
  final DateFormat formatter = DateFormat('hh:mm a');
  return formatter.format(time);
}

// Combine Date + Time
String formatDateTime(DateTime dateTime) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm a');
  return formatter.format(dateTime);
}
