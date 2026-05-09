import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/services/auth_service.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/helpers.dart';

class RiderDashboardScreen extends StatefulWidget {
  const RiderDashboardScreen({super.key});

  @override
  State<RiderDashboardScreen> createState() => _RiderDashboardScreenState();
}

class _RiderDashboardScreenState extends State<RiderDashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    _DeliveryTab(),
    _EarningsTab(),
    _RiderProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.delivery_dining_outlined),
            activeIcon: Icon(Icons.delivery_dining),
            label: 'Deliveries',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on_outlined),
            activeIcon: Icon(Icons.monetization_on),
            label: 'Earnings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _DeliveryTab extends StatelessWidget {
  const _DeliveryTab();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good morning,',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Rider John!',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.successColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppTheme.successColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'Online',
                        style: TextStyle(
                          color: AppTheme.successColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Row(
              children: [
                Expanded(
                  child: _StatCard(
                    icon: Icons.delivery_dining,
                    label: 'Today',
                    value: '8',
                    color: AppTheme.primaryColor,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    icon: Icons.star,
                    label: 'Rating',
                    value: '4.8',
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Row(
              children: [
                Expanded(
                  child: _StatCard(
                    icon: Icons.monetization_on,
                    label: 'Earnings',
                    value: '\$86.50',
                    color: AppTheme.successColor,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    icon: Icons.timer,
                    label: 'Online Time',
                    value: '5h 20m',
                    color: AppTheme.secondaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Available Deliveries',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _DeliveryRequestCard(
              store: 'Pizza Hut',
              customer: 'Alice W.',
              address: '456 Oak Ave',
              distance: '1.2 mi',
              payout: 5.50,
              onAccept: () {},
              onDecline: () {},
            ),
            _DeliveryRequestCard(
              store: 'Fresh Mart',
              customer: 'Bob M.',
              address: '789 Elm St',
              distance: '0.8 mi',
              payout: 4.50,
              onAccept: () {},
              onDecline: () {},
            ),
            _DeliveryRequestCard(
              store: 'Gas Express',
              customer: 'Carol S.',
              address: '321 Pine Rd',
              distance: '2.1 mi',
              payout: 6.00,
              onAccept: () {},
              onDecline: () {},
            ),
            const SizedBox(height: 16),
            const Text(
              'Active Delivery',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Card(
              color: AppTheme.primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.store,
                            color: Colors.white70, size: 18),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'Pick up from Fresh Mart',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'IN PROGRESS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.person,
                            color: Colors.white70, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          'Deliver to: David K.',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '0.5 mi away',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.navigation),
                        label: const Text('Navigate to Store'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppTheme.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DeliveryRequestCard extends StatelessWidget {
  final String store;
  final String customer;
  final String address;
  final String distance;
  final double payout;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const _DeliveryRequestCard({
    required this.store,
    required this.customer,
    required this.address,
    required this.distance,
    required this.payout,
    required this.onAccept,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.store,
                    color: AppTheme.primaryColor, size: 18),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    store,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.successColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    Helpers.formatPrice(payout),
                    style: const TextStyle(
                      color: AppTheme.successColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.person_outline,
                    size: 14, color: AppTheme.textSecondary),
                const SizedBox(width: 4),
                Text(customer),
                const SizedBox(width: 16),
                const Icon(Icons.location_on,
                    size: 14, color: AppTheme.textSecondary),
                const SizedBox(width: 4),
                Text(address),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.near_me,
                    size: 14, color: AppTheme.textSecondary),
                const SizedBox(width: 4),
                Text(
                  distance,
                  style: const TextStyle(color: AppTheme.textSecondary),
                ),
                const Spacer(),
                SizedBox(
                  height: 36,
                  child: OutlinedButton(
                    onPressed: onDecline,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.accentColor,
                      side: const BorderSide(color: AppTheme.accentColor),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    child: const Text('Decline'),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 36,
                  child: ElevatedButton(
                    onPressed: onAccept,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    child: const Text('Accept'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EarningsTab extends StatelessWidget {
  const _EarningsTab();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Earnings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Card(
              color: AppTheme.primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'Total Balance',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '\$486.50',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.account_balance),
                        label: const Text('Withdraw'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppTheme.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'This Week',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            const _EarningRow(day: 'Mon', amount: 32.50),
            const _EarningRow(day: 'Tue', amount: 45.00),
            const _EarningRow(day: 'Wed', amount: 28.00),
            const _EarningRow(day: 'Thu', amount: 52.00),
            const _EarningRow(day: 'Fri', amount: 38.50),
            const _EarningRow(day: 'Sat', amount: 65.00),
            const _EarningRow(day: 'Sun', amount: 0, isToday: true),
          ],
        ),
      ),
    );
  }
}

class _EarningRow extends StatelessWidget {
  final String day;
  final double amount;
  final bool isToday;

  const _EarningRow({
    required this.day,
    required this.amount,
    this.isToday = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 4),
      color: isToday ? AppTheme.primaryColor.withValues(alpha: 0.05) : null,
      child: ListTile(
        title: Text(
          day,
          style: TextStyle(
            fontWeight: isToday ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        trailing: Text(
          amount > 0 ? Helpers.formatPrice(amount) : 'No deliveries',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: amount > 0
                ? AppTheme.successColor
                : AppTheme.textLight,
          ),
        ),
      ),
    );
  }
}

class _RiderProfileTab extends StatelessWidget {
  const _RiderProfileTab();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();
    final user = auth.currentUser;
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Profile',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
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
                    user?.name ?? 'Rider',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    user?.email ?? '',
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _SmallStat(label: 'Deliveries', value: '156'),
                      SizedBox(width: 24),
                      _SmallStat(label: 'Rating', value: '4.8'),
                      SizedBox(width: 24),
                      _SmallStat(label: 'On Time', value: '98%'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Card(
              child: ListTile(
                leading: const Icon(Icons.motorcycle,
                    color: AppTheme.primaryColor),
                title: const Text('Vehicle Info'),
                subtitle: const Text('Honda Wave - ABC 1234'),
                trailing: const Icon(Icons.edit),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.document_scanner,
                    color: AppTheme.primaryColor),
                title: const Text('Documents'),
                subtitle: const Text('License, Insurance'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.notifications_outlined,
                    color: AppTheme.primaryColor),
                title: const Text('Notifications'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.headset_mic_outlined,
                    color: AppTheme.primaryColor),
                title: const Text('Support'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => context.read<AuthService>().logout(),
                icon: const Icon(Icons.logout),
                label: const Text('Log Out'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.accentColor,
                  side: const BorderSide(color: AppTheme.accentColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SmallStat extends StatelessWidget {
  final String label;
  final String value;

  const _SmallStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
