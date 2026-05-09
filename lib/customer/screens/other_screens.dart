import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/services/auth_service.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/helpers.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Order'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.store,
                          color: AppTheme.primaryColor, size: 20),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'Fresh Mart',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        Helpers.formatPrice(17.95),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Icon(Icons.timer,
                          size: 14, color: AppTheme.textSecondary),
                      SizedBox(width: 4),
                      Text(
                        'Estimated delivery: 20-30 min',
                        style: TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const _OrderStatusTile(
            icon: Icons.check_circle,
            iconColor: AppTheme.successColor,
            title: 'Order Placed',
            subtitle: 'Your order has been placed',
            time: '10:30 AM',
            isCompleted: true,
          ),
          const _OrderStatusTile(
            icon: Icons.check_circle,
            iconColor: AppTheme.successColor,
            title: 'Order Confirmed',
            subtitle: 'Restaurant confirmed your order',
            time: '10:32 AM',
            isCompleted: true,
          ),
          const _OrderStatusTile(
            icon: Icons.restaurant,
            iconColor: AppTheme.warningColor,
            title: 'Preparing',
            subtitle: 'Your order is being prepared',
            time: '10:35 AM',
            isCompleted: true,
            isActive: true,
          ),
          const _OrderStatusTile(
            icon: Icons.inventory_2,
            iconColor: AppTheme.textLight,
            title: 'Ready for Pickup',
            subtitle: 'Order is ready for rider pickup',
            isCompleted: false,
          ),
          const _OrderStatusTile(
            icon: Icons.delivery_dining,
            iconColor: AppTheme.textLight,
            title: 'Out for Delivery',
            subtitle: 'Rider is on the way',
            isCompleted: false,
          ),
          const _OrderStatusTile(
            icon: Icons.check_circle,
            iconColor: AppTheme.textLight,
            title: 'Delivered',
            subtitle: 'Order delivered successfully',
            isCompleted: false,
          ),
        ],
      ),
    );
  }
}

class _OrderStatusTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String? time;
  final bool isCompleted;
  final bool isActive;

  const _OrderStatusTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.time,
    this.isCompleted = false,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 40,
            child: Column(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: isCompleted || isActive ? 1 : 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 14,
                    color: isCompleted || isActive ? Colors.white : AppTheme.textLight,
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 2,
                    color: AppTheme.borderColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: isCompleted || isActive
                              ? AppTheme.textPrimary
                              : AppTheme.textLight,
                        ),
                      ),
                      const Spacer(),
                      if (time != null)
                        Text(
                          time!,
                          style: const TextStyle(
                            color: AppTheme.textLight,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: isCompleted || isActive
                          ? AppTheme.textSecondary
                          : AppTheme.textLight,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();
    final user = auth.currentUser;
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundColor: AppTheme.primaryColor,
                  child: Text(
                    (user?.name.isNotEmpty == true
                            ? user!.name[0]
                            : '?')
                        .toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  user?.name ?? 'User',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  user?.email ?? '',
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _SettingsTile(
            icon: Icons.person_outline,
            title: 'Personal Information',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.location_on_outlined,
            title: 'Saved Addresses',
            subtitle: '3 addresses',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.payment_outlined,
            title: 'Payment Methods',
            subtitle: '2 cards',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.favorite_outline,
            title: 'Favorites',
            subtitle: '12 items',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.card_giftcard_outlined,
            title: 'Promotions',
            subtitle: '3 available',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.headset_mic_outlined,
            title: 'Help & Support',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.info_outline,
            title: 'About',
            subtitle: 'Version 1.0.0',
            onTap: () {},
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => context.read<AuthService>().logout(),
              icon: const Icon(Icons.logout, color: AppTheme.accentColor),
              label: const Text('Log Out'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.accentColor,
                side: const BorderSide(color: AppTheme.accentColor),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.primaryColor),
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle!) : null,
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
