import 'package:flutter/material.dart';
import '../utils/helpers.dart';
import '../theme/app_theme.dart';

class OrderCard extends StatelessWidget {
  final String id;
  final String storeName;
  final String status;
  final double total;
  final int itemCount;
  final DateTime date;
  final VoidCallback? onTap;

  const OrderCard({
    super.key,
    required this.id,
    required this.storeName,
    required this.status,
    required this.total,
    required this.itemCount,
    required this.date,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = Helpers.statusColor(status);
    final statusIcon = Helpers.statusIcon(status);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    storeName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(statusIcon, size: 14, color: statusColor),
                        const SizedBox(width: 4),
                        Text(
                          Helpers.capitalize(status.replaceAll('_', ' ')),
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.shopping_bag_outlined,
                      size: 14, color: AppTheme.textSecondary),
                  const SizedBox(width: 4),
                  Text(
                    '$itemCount items',
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    Helpers.formatPrice(total),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                Helpers.formatDateTime(date),
                style: const TextStyle(
                  color: AppTheme.textLight,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
