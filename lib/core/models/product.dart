class Product {
  final String id;
  final String storeId;
  final String storeName;
  final String name;
  final String description;
  final double price;
  final double? discountedPrice;
  final String category;
  final String imageUrl;
  final String unit;
  final double rating;
  final int reviewCount;
  final bool isAvailable;
  final int stock;
  final DateTime createdAt;

  Product({
    required this.id,
    required this.storeId,
    required this.storeName,
    required this.name,
    required this.description,
    required this.price,
    this.discountedPrice,
    required this.category,
    required this.imageUrl,
    this.unit = 'piece',
    this.rating = 0.0,
    this.reviewCount = 0,
    this.isAvailable = true,
    this.stock = 0,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  double get effectivePrice => discountedPrice ?? price;

  Map<String, dynamic> toMap() => {
        'id': id,
        'storeId': storeId,
        'storeName': storeName,
        'name': name,
        'description': description,
        'price': price,
        'discountedPrice': discountedPrice,
        'category': category,
        'imageUrl': imageUrl,
        'unit': unit,
        'rating': rating,
        'reviewCount': reviewCount,
        'isAvailable': isAvailable,
        'stock': stock,
        'createdAt': createdAt.toIso8601String(),
      };

  factory Product.fromMap(Map<String, dynamic> map) => Product(
        id: map['id'],
        storeId: map['storeId'],
        storeName: map['storeName'],
        name: map['name'],
        description: map['description'],
        price: (map['price'] as num).toDouble(),
        discountedPrice: (map['discountedPrice'] as num?)?.toDouble(),
        category: map['category'],
        imageUrl: map['imageUrl'],
        unit: map['unit'] ?? 'piece',
        rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
        reviewCount: map['reviewCount'] ?? 0,
        isAvailable: map['isAvailable'] ?? true,
        stock: map['stock'] ?? 0,
        createdAt: map['createdAt'] != null
            ? DateTime.parse(map['createdAt'])
            : DateTime.now(),
      );
}
