class AppConstants {
  static const String appName = 'EPA';
  static const String baseUrl = 'https://api.epa-delivery.com';

  static const List<String> categories = [
    'Groceries',
    'Household',
    'Fast Food',
    'Gas Refill',
    'Water Refill',
  ];

  static const List<Map<String, String>> categoryDetails = [
    {'name': 'Groceries', 'icon': 'groceries', 'color': '#4CAF50'},
    {'name': 'Household', 'icon': 'household', 'color': '#FF9800'},
    {'name': 'Fast Food', 'icon': 'fast_food', 'color': '#F44336'},
    {'name': 'Gas Refill', 'icon': 'gas', 'color': '#2196F3'},
    {'name': 'Water Refill', 'icon': 'water', 'color': '#00BCD4'},
  ];

  static const List<String> orderStatuses = [
    'pending',
    'confirmed',
    'preparing',
    'ready',
    'picked_up',
    'delivered',
    'cancelled',
  ];

  static const double deliveryFee = 2.99;
  static const double serviceFee = 0.99;
  static const double minOrderAmount = 5.0;
  static const double maxDeliveryRadiusKm = 10.0;
}
