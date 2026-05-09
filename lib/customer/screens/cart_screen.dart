import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/helpers.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock cart data
    final cartItems = [
      {
        'name': 'Fresh Organic Bananas',
        'price': 1.99,
        'qty': 2,
        'image': 'https://picsum.photos/seed/banana/100',
      },
      {
        'name': 'Margherita Pizza',
        'price': 9.99,
        'qty': 1,
        'image': 'https://picsum.photos/seed/pizza/100',
      },
    ];

    final subtotal = cartItems.fold(0.0, (s, i) => s + (i['price'] as double) * (i['qty'] as int));
    const deliveryFee = 2.99;
    const serviceFee = 0.99;
    final total = subtotal + deliveryFee + serviceFee;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: cartItems.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (_, i) {
                final item = cartItems[i];
                return Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: 72,
                        height: 72,
                        color: Colors.grey[200],
                        child: Image.network(
                          item['image'] as String,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.image, color: AppTheme.textLight),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['name'] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            Helpers.formatPrice(item['price'] as double),
                            style: const TextStyle(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppTheme.borderColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.remove, size: 16),
                            constraints: const BoxConstraints(
                                minWidth: 32, minHeight: 32),
                          ),
                          Text(
                            '${item['qty']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.add, size: 16),
                            constraints: const BoxConstraints(
                                minWidth: 32, minHeight: 32),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Column(
                children: [
                  _PriceRow(label: 'Subtotal', amount: subtotal),
                  const SizedBox(height: 4),
                  const _PriceRow(label: 'Delivery Fee', amount: deliveryFee),
                  const SizedBox(height: 4),
                  const _PriceRow(label: 'Service Fee', amount: serviceFee),
                  const Divider(height: 16),
                  _PriceRow(
                    label: 'Total',
                    amount: total,
                    isBold: true,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const _CheckoutScreen()),
                      ),
                      child: Text(
                          'Proceed to Checkout - ${Helpers.formatPrice(total)}'),
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

class _PriceRow extends StatelessWidget {
  final String label;
  final double amount;
  final bool isBold;

  const _PriceRow({
    required this.label,
    required this.amount,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppTheme.textSecondary,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
            fontSize: isBold ? 16 : 14,
          ),
        ),
        Text(
          Helpers.formatPrice(amount),
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            fontSize: isBold ? 18 : 14,
            color: isBold ? AppTheme.textPrimary : AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _CheckoutScreen extends StatelessWidget {
  const _CheckoutScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Delivery Address',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.location_on, color: AppTheme.primaryColor),
              title: const Text('Home'),
              subtitle: const Text('123 Main St, Downtown'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Payment Method',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.credit_card, color: AppTheme.primaryColor),
              title: const Text('Credit Card'),
              subtitle: const Text('**** 4242'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Order Summary',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  _PriceRow(label: 'Items (3)', amount: 13.97),
                  SizedBox(height: 4),
                  _PriceRow(label: 'Delivery Fee', amount: 2.99),
                  SizedBox(height: 4),
                  _PriceRow(label: 'Service Fee', amount: 0.99),
                  Divider(height: 16),
                  _PriceRow(label: 'Total', amount: 17.95, isBold: true),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.check_circle,
                            color: AppTheme.successColor, size: 64),
                        const SizedBox(height: 16),
                        const Text(
                          'Order Placed!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Your order has been placed successfully',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppTheme.textSecondary),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text('Track Order'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: const Text('Place Order'),
            ),
          ),
        ],
      ),
    );
  }
}
