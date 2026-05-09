import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/services/auth_service.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/helpers.dart';

class VendorDashboardScreen extends StatefulWidget {
  const VendorDashboardScreen({super.key});

  @override
  State<VendorDashboardScreen> createState() => _VendorDashboardScreenState();
}

class _VendorDashboardScreenState extends State<VendorDashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    _VendorHomeTab(),
    _VendorOrdersTab(),
    _VendorProductsTab(),
    _VendorSettingsTab(),
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
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            activeIcon: Icon(Icons.inventory_2),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class _VendorHomeTab extends StatelessWidget {
  const _VendorHomeTab();

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
                      'Welcome back,',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Fresh Mart',
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
                        'Open',
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
                  child: _VendorStatCard(
                    label: 'Today\'s Revenue',
                    value: '\$1,245',
                    change: '+12.5%',
                    isPositive: true,
                    icon: Icons.trending_up,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _VendorStatCard(
                    label: 'Orders Today',
                    value: '28',
                    change: '+8.3%',
                    isPositive: true,
                    icon: Icons.shopping_bag,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Row(
              children: [
                Expanded(
                  child: _VendorStatCard(
                    label: 'Pending Orders',
                    value: '5',
                    change: 'Needs attention',
                    isPositive: false,
                    icon: Icons.pending_actions,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _VendorStatCard(
                    label: 'Rating',
                    value: '4.5',
                    change: '★ 89 reviews',
                    isPositive: true,
                    icon: Icons.star,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Recent Orders',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const _VendorOrderCard(
              orderId: '#1042',
              customer: 'Alice W.',
              items: '3 items',
              total: 24.50,
              status: 'pending',
              time: '2 min ago',
            ),
            const _VendorOrderCard(
              orderId: '#1041',
              customer: 'Bob M.',
              items: '2 items',
              total: 15.99,
              status: 'confirmed',
              time: '5 min ago',
            ),
            const _VendorOrderCard(
              orderId: '#1040',
              customer: 'Carol S.',
              items: '5 items',
              total: 42.00,
              status: 'preparing',
              time: '12 min ago',
            ),
            const _VendorOrderCard(
              orderId: '#1039',
              customer: 'David K.',
              items: '1 item',
              total: 6.99,
              status: 'ready',
              time: '18 min ago',
            ),
          ],
        ),
      ),
    );
  }
}

class _VendorStatCard extends StatelessWidget {
  final String label;
  final String value;
  final String change;
  final bool isPositive;
  final IconData icon;

  const _VendorStatCard({
    required this.label,
    required this.value,
    required this.change,
    required this.isPositive,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: isPositive
                        ? AppTheme.successColor.withValues(alpha: 0.1)
                        : AppTheme.warningColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    size: 16,
                    color: isPositive
                        ? AppTheme.successColor
                        : AppTheme.warningColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              change,
              style: TextStyle(
                color: isPositive
                    ? AppTheme.successColor
                    : AppTheme.warningColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VendorOrderCard extends StatelessWidget {
  final String orderId;
  final String customer;
  final String items;
  final double total;
  final String status;
  final String time;

  const _VendorOrderCard({
    required this.orderId,
    required this.customer,
    required this.items,
    required this.total,
    required this.status,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = Helpers.statusColor(status);
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Helpers.statusIcon(status),
                color: statusColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        orderId,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        customer,
                        style: const TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        items,
                        style: const TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        Helpers.formatPrice(total),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryColor,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    Helpers.capitalize(status),
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(
                    color: AppTheme.textLight,
                    fontSize: 11,
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

class _VendorOrdersTab extends StatelessWidget {
  const _VendorOrdersTab();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Orders',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Filter',
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          DefaultTabController(
            length: 5,
            child: Column(
              children: [
                const TabBar(
                  isScrollable: true,
                  labelColor: AppTheme.primaryColor,
                  unselectedLabelColor: AppTheme.textSecondary,
                  indicatorColor: AppTheme.primaryColor,
                  tabs: [
                    Tab(text: 'Pending'),
                    Tab(text: 'Confirmed'),
                    Tab(text: 'Preparing'),
                    Tab(text: 'Ready'),
                    Tab(text: 'Completed'),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 300,
                  child: const TabBarView(
                    children: [
                      _OrderList(status: 'pending'),
                      _OrderList(status: 'confirmed'),
                      _OrderList(status: 'preparing'),
                      _OrderList(status: 'ready'),
                      _OrderList(status: 'delivered'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderList extends StatelessWidget {
  final String status;
  const _OrderList({required this.status});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (_, i) => Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '#${1043 - i}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    Helpers.formatPrice((10.0 + i * 5)),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text('Customer: Alice W.'),
              const Text('Items: 3 items'),
              const SizedBox(height: 8),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text('Decline'),
                  ),
                  const SizedBox(width: 8),
                  if (status == 'pending')
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.successColor,
                      ),
                      child: const Text('Accept'),
                    )
                  else if (status == 'confirmed')
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.warningColor,
                      ),
                      child: const Text('Start Preparing'),
                    )
                  else if (status == 'preparing')
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                      ),
                      child: const Text('Mark Ready'),
                    )
                  else if (status == 'ready')
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.secondaryColor,
                      ),
                      child: const Text('Handed to Rider'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VendorProductsTab extends StatelessWidget {
  const _VendorProductsTab();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Products',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FloatingActionButton.small(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const _AddProductScreen()),
                  ),
                  backgroundColor: AppTheme.primaryColor,
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 10,
              itemBuilder: (_, i) {
                final categories = [
                  'Groceries', 'Household', 'Fast Food', 'Gas Refill', 'Water Refill'
                ];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: 48,
                        height: 48,
                        color: AppTheme.primaryColor.withValues(alpha: 0.1),
                        child: const Icon(Icons.inventory_2,
                            color: AppTheme.primaryColor),
                      ),
                    ),
                    title: Text('Product ${i + 1}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(categories[i % categories.length]),
                        Text(
                          Helpers.formatPrice(5.99 + i),
                          style: const TextStyle(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Switch(
                          value: true,
                          activeThumbColor: AppTheme.successColor,
                          onChanged: (_) {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit_outlined,
                              size: 20),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AddProductScreen extends StatelessWidget {
  const _AddProductScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add_photo_alternate,
                      size: 48, color: AppTheme.textLight),
                  SizedBox(height: 8),
                  Text(
                    'Add Product Image',
                    style: TextStyle(color: AppTheme.textSecondary),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Product Name',
              hintText: 'Enter product name',
            ),
          ),
          const SizedBox(height: 12),
          const TextField(
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Description',
              hintText: 'Enter product description',
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    prefixText: '\$ ',
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Discounted Price',
                    prefixText: '\$ ',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField(
            decoration: const InputDecoration(labelText: 'Category'),
            items: const [
              DropdownMenuItem(value: 'Groceries', child: Text('Groceries')),
              DropdownMenuItem(value: 'Household', child: Text('Household')),
              DropdownMenuItem(value: 'Fast Food', child: Text('Fast Food')),
              DropdownMenuItem(value: 'Gas Refill', child: Text('Gas Refill')),
              DropdownMenuItem(value: 'Water Refill', child: Text('Water Refill')),
            ],
            onChanged: (_) {},
          ),
          const SizedBox(height: 12),
          const TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Stock',
              hintText: 'Enter quantity',
            ),
          ),
          const SizedBox(height: 12),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Unit',
              hintText: 'e.g. piece, kg, liter',
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Add Product'),
            ),
          ),
        ],
      ),
    );
  }
}

class _VendorSettingsTab extends StatelessWidget {
  const _VendorSettingsTab();

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
              'Store Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundColor:
                              AppTheme.primaryColor.withValues(alpha: 0.1),
                          child: Text(
                            (user?.name.isNotEmpty == true
                                    ? user!.name[0]
                                    : '?')
                                .toUpperCase(),
                            style: const TextStyle(
                                color: AppTheme.primaryColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user?.name ?? 'Store',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const Text(
                                'Grocery Store',
                                style: TextStyle(
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Business Hours',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const _HourRow(day: 'Mon - Fri', hours: '8:00 AM - 10:00 PM'),
            const _HourRow(day: 'Saturday', hours: '9:00 AM - 11:00 PM'),
            const _HourRow(day: 'Sunday', hours: '10:00 AM - 8:00 PM'),
            const SizedBox(height: 16),
            const Text(
              'Delivery Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('Store Open'),
                    subtitle: const Text('Accept new orders'),
                    value: true,
                    activeThumbColor: AppTheme.primaryColor,
                    onChanged: (_) {},
                  ),
                  SwitchListTile(
                    title: const Text('Accept Pre-orders'),
                    value: false,
                    activeThumbColor: AppTheme.primaryColor,
                    onChanged: (_) {},
                  ),
                ],
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Delivery Radius'),
                subtitle: const Text('5 km'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Minimum Order'),
                subtitle: const Text('\$5.00'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Delivery Fee'),
                subtitle: const Text('\$2.99'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Account',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                leading: const Icon(Icons.person_outline,
                    color: AppTheme.primaryColor),
                title: const Text('Profile'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.payment_outlined,
                    color: AppTheme.primaryColor),
                title: const Text('Payouts'),
                subtitle: const Text('Bank: ****4567'),
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

class _HourRow extends StatelessWidget {
  final String day;
  final String hours;

  const _HourRow({required this.day, required this.hours});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 4),
      child: ListTile(
        title: Text(day),
        trailing: Text(
          hours,
          style: const TextStyle(
            color: AppTheme.textSecondary,
          ),
        ),
      ),
    );
  }
}
