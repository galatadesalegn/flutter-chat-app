import 'package:intl/intl.dart';

String formatTime(DateTime dt) => DateFormat.jm().format(dt);

String formatDate(DateTime dt) {
  final now = DateTime.now();
  final diff = now.difference(dt).inDays;
  if (diff == 0) return 'Today';
  if (diff == 1) return 'Yesterday';
  if (diff < 7) return '$diff days ago';
  return DateFormat.MMMd().format(dt);
}

String truncate(String text, int maxLength) =>
    text.length <= maxLength ? text : '${text.substring(0, maxLength)}...';
