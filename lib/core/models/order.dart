class OrderItem {
  final String productId;
  final String productName;
  final String productImage;
  final double price;
  final int quantity;
  final String unit;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.quantity,
    this.unit = 'piece',
  });

  double get total => price * quantity;
}

class Order {
  final String id;
  final String customerId;
  final String customerName;
  final String customerPhone;
  final String? customerAddress;
  final String? storeId;
  final String storeName;
  final String? riderId;
  final String? riderName;
  final List<OrderItem> items;
  final double subtotal;
  final double deliveryFee;
  final double serviceFee;
  final double total;
  final String status;
  final String? notes;
  final double? deliveryLat;
  final double? deliveryLng;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Order({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.customerPhone,
    this.customerAddress,
    this.storeId,
    required this.storeName,
    this.riderId,
    this.riderName,
    required this.items,
    required this.subtotal,
    this.deliveryFee = 2.99,
    this.serviceFee = 0.99,
    required this.total,
    this.status = 'pending',
    this.notes,
    this.deliveryLat,
    this.deliveryLng,
    DateTime? createdAt,
    this.updatedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() => {
        'id': id,
        'customerId': customerId,
        'customerName': customerName,
        'customerPhone': customerPhone,
        'customerAddress': customerAddress,
        'storeId': storeId,
        'storeName': storeName,
        'riderId': riderId,
        'riderName': riderName,
        'items': items.map((i) => {
              'productId': i.productId,
              'productName': i.productName,
              'productImage': i.productImage,
              'price': i.price,
              'quantity': i.quantity,
              'unit': i.unit,
            }).toList(),
        'subtotal': subtotal,
        'deliveryFee': deliveryFee,
        'serviceFee': serviceFee,
        'total': total,
        'status': status,
        'notes': notes,
        'deliveryLat': deliveryLat,
        'deliveryLng': deliveryLng,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };

  factory Order.fromMap(Map<String, dynamic> map) {
    final itemsList = (map['items'] as List<dynamic>?) ?? [];
    return Order(
      id: map['id'],
      customerId: map['customerId'],
      customerName: map['customerName'],
      customerPhone: map['customerPhone'],
      customerAddress: map['customerAddress'],
      storeId: map['storeId'],
      storeName: map['storeName'],
      riderId: map['riderId'],
      riderName: map['riderName'],
      items: itemsList.map((i) => OrderItem(
            productId: i['productId'],
            productName: i['productName'],
            productImage: i['productImage'],
            price: (i['price'] as num).toDouble(),
            quantity: i['quantity'],
            unit: i['unit'] ?? 'piece',
          )).toList(),
      subtotal: (map['subtotal'] as num).toDouble(),
      deliveryFee: (map['deliveryFee'] as num?)?.toDouble() ?? 2.99,
      serviceFee: (map['serviceFee'] as num?)?.toDouble() ?? 0.99,
      total: (map['total'] as num).toDouble(),
      status: map['status'] ?? 'pending',
      notes: map['notes'],
      deliveryLat: (map['deliveryLat'] as num?)?.toDouble(),
      deliveryLng: (map['deliveryLng'] as num?)?.toDouble(),
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'])
          : null,
    );
  }
}
