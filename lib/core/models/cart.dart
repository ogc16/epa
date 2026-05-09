import 'product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get totalPrice => product.effectivePrice * quantity;
}

class Cart {
  final String id;
  final String customerId;
  final String? storeId;
  final List<CartItem> items;
  final double deliveryFee;
  final double serviceFee;

  Cart({
    required this.id,
    required this.customerId,
    this.storeId,
    this.items = const [],
    this.deliveryFee = 2.99,
    this.serviceFee = 0.99,
  });

  double get subtotal =>
      items.fold(0.0, (sum, item) => sum + item.totalPrice);

  double get total => subtotal + deliveryFee + serviceFee;

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
}
