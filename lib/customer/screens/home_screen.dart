import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_constants.dart';
import '../../core/models/order.dart';
import '../../core/models/product.dart';
import '../../core/services/auth_service.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../core/widgets/category_item.dart';
import '../../core/widgets/order_card.dart';
import '../../core/widgets/product_card.dart';
import 'other_screens.dart';
import 'product_detail_screen.dart';
import 'cart_screen.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int _currentIndex = 0;
  String _selectedCategory = 'All';
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      _HomeTab(
        selectedCategory: _selectedCategory,
        searchController: _searchController,
        onCategoryChanged: (cat) => setState(() => _selectedCategory = cat),
      ),
      const _OrdersTab(),
      const _ProfileTab(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'Orders',
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

class _HomeTab extends StatelessWidget {
  final String selectedCategory;
  final TextEditingController searchController;
  final ValueChanged<String> onCategoryChanged;

  const _HomeTab({
    required this.selectedCategory,
    required this.searchController,
    required this.onCategoryChanged,
  });

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
                      'Deliver to',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on,
                            size: 16, color: AppTheme.primaryColor),
                        SizedBox(width: 4),
                        Text(
                          'Home',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ],
                ),
                Stack(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const CartScreen()),
                      ),
                      icon: const Icon(Icons.shopping_cart_outlined),
                    ),
                    Positioned(
                      right: 4,
                      top: 4,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: AppTheme.accentColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Text(
                          '2',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            SearchField(
              controller: searchController,
              onChanged: (_) {},
              onFilterTap: () {},
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 180,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.primaryColor,
                        AppTheme.primaryColor.withValues(alpha: 0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Free delivery',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'on your first 5 orders',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: AppTheme.primaryColor,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 10),
                              ),
                              child: const Text('Order Now'),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.local_shipping,
                        color: Colors.white,
                        size: 72,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const SectionHeader(title: 'Categories'),
            const SizedBox(height: 12),
            SizedBox(
              height: 48,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  CategoryItem(
                    name: 'All',
                    icon: 'all',
                    colorHex: '#6C63FF',
                    isSelected: selectedCategory == 'All',
                    onTap: () => onCategoryChanged('All'),
                  ),
                  ...AppConstants.categoryDetails.map(
                    (cat) => Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: CategoryItem(
                        name: cat['name']!,
                        icon: cat['icon']!,
                        colorHex: cat['color']!,
                        isSelected: selectedCategory == cat['name'],
                        onTap: () => onCategoryChanged(cat['name']!),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const SectionHeader(
              title: 'Featured Products',
              actionLabel: 'See All',
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 260,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: _featuredProducts.map((product) => SizedBox(
                  width: 170,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: ProductCard(
                      id: product.id,
                      name: product.name,
                      imageUrl: product.imageUrl,
                      price: product.price,
                      discountedPrice: product.discountedPrice,
                      rating: product.rating,
                      unit: product.unit,
                      category: product.category,
                      storeName: product.storeName,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ProductDetailScreen(product: product),
                        ),
                      ),
                      onAddToCart: () {},
                    ),
                  ),
                )).toList(),
              ),
            ),
            const SizedBox(height: 24),
            const SectionHeader(
              title: 'Nearby Stores',
              actionLabel: 'See All',
            ),
            const SizedBox(height: 12),
            ..._nearbyStores.map((store) => _StoreCard(store: store)),
            const SizedBox(height: 24),
            const SectionHeader(title: 'Popular Items'),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _popularItems.length,
              itemBuilder: (_, i) => ProductCard(
                id: _popularItems[i].id,
                name: _popularItems[i].name,
                imageUrl: _popularItems[i].imageUrl,
                price: _popularItems[i].price,
                discountedPrice: _popularItems[i].discountedPrice,
                rating: _popularItems[i].rating,
                unit: _popularItems[i].unit,
                category: _popularItems[i].category,
                storeName: _popularItems[i].storeName,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ProductDetailScreen(product: _popularItems[i]),
                  ),
                ),
                onAddToCart: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StoreCard extends StatelessWidget {
  final Map<String, dynamic> store;
  const _StoreCard({required this.store});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.1),
          child: const Icon(Icons.store, color: AppTheme.primaryColor),
        ),
        title: Text(
          store['name'],
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(store['address']),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.star, size: 14, color: Colors.amber),
                const SizedBox(width: 4),
                Text('${store['rating']}'),
                const SizedBox(width: 8),
                const Icon(Icons.timer, size: 14, color: AppTheme.textSecondary),
                const SizedBox(width: 4),
                Text(store['time']),
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }
}

class _OrdersTab extends StatelessWidget {
  const _OrdersTab();

  @override
  Widget build(BuildContext context) {
    final orders = _mockOrders;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Orders',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: orders.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.receipt_long,
                              size: 64, color: AppTheme.textLight),
                          SizedBox(height: 16),
                          Text(
                            'No orders yet',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Your orders will appear here',
                            style:
                                TextStyle(color: AppTheme.textSecondary),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (_, i) => OrderCard(
                        id: orders[i].id,
                        storeName: orders[i].storeName,
                        status: orders[i].status,
                        total: orders[i].total,
                        itemCount: orders[i].items.length,
                        date: orders[i].createdAt,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const OrderTrackingScreen(),
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

final List<Order> _mockOrders = [
  Order(
    id: '#1042',
    customerId: 'user_1',
    customerName: 'John Doe',
    customerPhone: '+1234567890',
    storeName: 'Fresh Mart',
    storeId: 's1',
    items: [
      OrderItem(
        productId: 'p1',
        productName: 'Fresh Organic Bananas',
        productImage: '',
        price: 1.99,
        quantity: 2,
      ),
      OrderItem(
        productId: 'p5',
        productName: 'Fresh Milk 1L',
        productImage: '',
        price: 1.50,
        quantity: 1,
      ),
      OrderItem(
        productId: 'p6',
        productName: 'Wheat Bread',
        productImage: '',
        price: 2.49,
        quantity: 1,
      ),
    ],
    subtotal: 7.97,
    total: 11.95,
    status: 'delivered',
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
  Order(
    id: '#1041',
    customerId: 'user_1',
    customerName: 'John Doe',
    customerPhone: '+1234567890',
    storeName: 'Pizza Hut',
    storeId: 's2',
    items: [
      OrderItem(
        productId: 'p2',
        productName: 'Margherita Pizza',
        productImage: '',
        price: 9.99,
        quantity: 1,
      ),
    ],
    subtotal: 9.99,
    total: 13.97,
    status: 'preparing',
    createdAt: DateTime.now().subtract(const Duration(hours: 3)),
  ),
  Order(
    id: '#1040',
    customerId: 'user_1',
    customerName: 'John Doe',
    customerPhone: '+1234567890',
    storeName: 'Gas Express',
    storeId: 's3',
    items: [
      OrderItem(
        productId: 'p3',
        productName: 'LPG Gas Refill',
        productImage: '',
        price: 25.00,
        quantity: 1,
      ),
    ],
    subtotal: 25.00,
    total: 28.98,
    status: 'pending',
    createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
  ),
];

class _ProfileTab extends StatelessWidget {
  const _ProfileTab();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();
    final user = auth.currentUser;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Profile',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: ListTile(
                leading: CircleAvatar(
                  radius: 24,
                  backgroundColor: AppTheme.primaryColor,
                  child: Text(
                    (user?.name.isNotEmpty == true
                            ? user!.name[0]
                            : '?')
                        .toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text(
                  user?.name ?? 'User',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(user?.email ?? ''),
                trailing: const Icon(Icons.edit),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 16),
            _ProfileMenuItem(
              icon: Icons.location_on_outlined,
              title: 'Saved Addresses',
              onTap: () {},
            ),
            _ProfileMenuItem(
              icon: Icons.payment_outlined,
              title: 'Payment Methods',
              onTap: () {},
            ),
            _ProfileMenuItem(
              icon: Icons.notifications_outlined,
              title: 'Notifications',
              onTap: () {},
            ),
            _ProfileMenuItem(
              icon: Icons.help_outline,
              title: 'Help & Support',
              onTap: () {},
            ),
            _ProfileMenuItem(
              icon: Icons.settings_outlined,
              title: 'Settings',
              onTap: () {},
            ),
            const Spacer(),
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

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.primaryColor),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

final List<Product> _featuredProducts = [
  Product(
    id: 'p1', storeId: 's1', storeName: 'Fresh Mart',
    name: 'Fresh Organic Bananas', description: 'Bunch of fresh organic bananas',
    price: 2.99, discountedPrice: 1.99, category: 'Groceries',
    imageUrl: 'https://picsum.photos/seed/banana/200', rating: 4.5, reviewCount: 128, unit: 'bunch', stock: 50,
  ),
  Product(
    id: 'p2', storeId: 's2', storeName: 'Pizza Hut',
    name: 'Margherita Pizza', description: 'Classic cheese pizza',
    price: 12.99, discountedPrice: 9.99, category: 'Fast Food',
    imageUrl: 'https://picsum.photos/seed/pizza/200', rating: 4.7, reviewCount: 89, unit: 'large', stock: 20,
  ),
  Product(
    id: 'p3', storeId: 's3', storeName: 'Gas Express',
    name: 'LPG Gas Refill', description: '12.5kg LPG cylinder refill',
    price: 25.00, category: 'Gas Refill',
    imageUrl: 'https://picsum.photos/seed/gas/200', rating: 4.3, reviewCount: 210, unit: 'cylinder', stock: 100,
  ),
  Product(
    id: 'p4', storeId: 's4', storeName: 'Aqua Pure',
    name: '5 Gallon Water Refill', description: 'Purified drinking water',
    price: 3.50, category: 'Water Refill',
    imageUrl: 'https://picsum.photos/seed/water/200', rating: 4.8, reviewCount: 345, unit: 'gallon', stock: 200,
  ),
];

final List<Product> _popularItems = [
  Product(
    id: 'p5', storeId: 's1', storeName: 'Fresh Mart',
    name: 'Fresh Milk 1L', description: 'Fresh whole milk',
    price: 1.50, category: 'Groceries',
    imageUrl: 'https://picsum.photos/seed/milk/200', rating: 4.4, reviewCount: 92, unit: 'liter', stock: 80,
  ),
  Product(
    id: 'p6', storeId: 's1', storeName: 'Fresh Mart',
    name: 'Wheat Bread', description: 'Whole wheat bread loaf',
    price: 2.49, category: 'Groceries',
    imageUrl: 'https://picsum.photos/seed/bread/200', rating: 4.2, reviewCount: 67, unit: 'loaf', stock: 40,
  ),
  Product(
    id: 'p7', storeId: 's2', storeName: 'Burger King',
    name: 'Whopper Burger', description: 'Flame-grilled beef burger',
    price: 6.99, discountedPrice: 5.49, category: 'Fast Food',
    imageUrl: 'https://picsum.photos/seed/burger/200', rating: 4.5, reviewCount: 156, unit: 'piece', stock: 30,
  ),
  Product(
    id: 'p8', storeId: 's1', storeName: 'Fresh Mart',
    name: 'Detergent Powder 2kg', description: 'Laundry detergent',
    price: 8.99, category: 'Household',
    imageUrl: 'https://picsum.photos/seed/detergent/200', rating: 4.1, reviewCount: 45, unit: 'pack', stock: 60,
  ),
];

final List<Map<String, dynamic>> _nearbyStores = [
  {'name': 'Fresh Mart', 'address': '123 Main St, Downtown', 'rating': 4.5, 'time': '15-25 min'},
  {'name': 'Pizza Hut', 'address': '456 Oak Ave, Midtown', 'rating': 4.3, 'time': '20-30 min'},
  {'name': 'Gas Express', 'address': '789 Elm St, Uptown', 'rating': 4.6, 'time': '10-20 min'},
  {'name': 'Aqua Pure', 'address': '321 Pine Rd, Suburbs', 'rating': 4.8, 'time': '15-20 min'},
];
