import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Helpers {
  static String formatPrice(double amount) =>
      '\$${amount.toStringAsFixed(2)}';

  static String formatDate(DateTime date) =>
      DateFormat('MMM dd, yyyy').format(date);

  static String formatTime(DateTime date) =>
      DateFormat('hh:mm a').format(date);

  static String formatDateTime(DateTime date) =>
      DateFormat('MMM dd, yyyy hh:mm a').format(date);

  static String timeAgo(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays > 7) return formatDate(date);
    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
    return 'just now';
  }

  static String capitalize(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);

  static String truncate(String s, int maxLength) =>
      s.length <= maxLength ? s : '${s.substring(0, maxLength)}...';

  static String maskPhone(String phone) {
    if (phone.length < 6) return phone;
    return '${phone.substring(0, 3)}****${phone.substring(phone.length - 3)}';
  }

  static Color statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return const Color(0xFFFF9800);
      case 'confirmed':
        return const Color(0xFF2196F3);
      case 'preparing':
        return const Color(0xFF9C27B0);
      case 'ready':
        return const Color(0xFF4CAF50);
      case 'picked_up':
        return const Color(0xFF00BCD4);
      case 'delivered':
        return const Color(0xFF4CAF50);
      case 'cancelled':
        return const Color(0xFFE53935);
      default:
        return const Color(0xFF9E9E9E);
    }
  }

  static IconData statusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Icons.schedule;
      case 'confirmed':
        return Icons.check_circle_outline;
      case 'preparing':
        return Icons.restaurant;
      case 'ready':
        return Icons.inventory_2;
      case 'picked_up':
        return Icons.delivery_dining;
      case 'delivered':
        return Icons.check_circle;
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.help_outline;
    }
  }

  static bool isEmoji(String s) =>
      s.isNotEmpty && s.runes.length == 1 && s.runes.first > 0x1F000;
}
