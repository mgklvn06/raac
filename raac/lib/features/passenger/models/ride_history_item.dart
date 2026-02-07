import 'package:raac/features/rides/models/ride_model.dart';

class RideHistoryItem {
  final Ride ride;
  final DateTime dateTime;
  final String driverName;
  final String plate;

  RideHistoryItem({
    required this.ride,
    required this.dateTime,
    required this.driverName,
    required this.plate,
  });

  String get prettyDate {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    if (difference.inDays == 0) {
      return 'Today ${_formatTime(dateTime)}';
    }
    if (difference.inDays == 1) {
      return 'Yesterday ${_formatTime(dateTime)}';
    }
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  String _formatTime(DateTime date) {
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}
