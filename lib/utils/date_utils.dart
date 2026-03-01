import 'package:intl/intl.dart';

bool isExpiringSoon(DateTime date, {int days = 3}) {
  final now = DateTime.now();
  final diff = date.difference(DateTime(now.year, now.month, now.day));
  return diff.inDays >= 0 && diff.inDays <= days;
}

int daysUntil(DateTime date) {
  final now = DateTime.now();
  final diff = date.difference(DateTime(now.year, now.month, now.day));
  return diff.inDays;
}

String formatDate(DateTime date) {
  return DateFormat.yMMMd().format(date);
}
