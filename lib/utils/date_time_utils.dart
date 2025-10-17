import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(date);
}

String formatTime(DateTime time) {
  final DateFormat formatter = DateFormat('hh:mm a');
  return formatter.format(time);
}

String formatDateTime(DateTime dateTime) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm a');
  return formatter.format(dateTime);
}
