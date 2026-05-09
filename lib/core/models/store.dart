class Store {
  final String id;
  final String name;
  final String description;
  final String phone;
  final String address;
  final double lat;
  final double lng;
  final String? photoUrl;
  final String? coverUrl;
  final List<String> categories;
  final double rating;
  final int reviewCount;
  final double deliveryFee;
  final double minOrder;
  final String? deliveryTime;
  final bool isOpen;
  final bool isAvailable;
  final DateTime createdAt;

  Store({
    required this.id,
    required this.name,
    required this.description,
    required this.phone,
    required this.address,
    required this.lat,
    required this.lng,
    this.photoUrl,
    this.coverUrl,
    this.categories = const [],
    this.rating = 0.0,
    this.reviewCount = 0,
    this.deliveryFee = 2.99,
    this.minOrder = 5.0,
    this.deliveryTime,
    this.isOpen = true,
    this.isAvailable = true,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'phone': phone,
        'address': address,
        'lat': lat,
        'lng': lng,
        'photoUrl': photoUrl,
        'coverUrl': coverUrl,
        'categories': categories,
        'rating': rating,
        'reviewCount': reviewCount,
        'deliveryFee': deliveryFee,
        'minOrder': minOrder,
        'deliveryTime': deliveryTime,
        'isOpen': isOpen,
        'isAvailable': isAvailable,
        'createdAt': createdAt.toIso8601String(),
      };

  factory Store.fromMap(Map<String, dynamic> map) => Store(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        phone: map['phone'],
        address: map['address'],
        lat: (map['lat'] as num).toDouble(),
        lng: (map['lng'] as num).toDouble(),
        photoUrl: map['photoUrl'],
        coverUrl: map['coverUrl'],
        categories: List<String>.from(map['categories'] ?? []),
        rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
        reviewCount: map['reviewCount'] ?? 0,
        deliveryFee: (map['deliveryFee'] as num?)?.toDouble() ?? 2.99,
        minOrder: (map['minOrder'] as num?)?.toDouble() ?? 5.0,
        deliveryTime: map['deliveryTime'],
        isOpen: map['isOpen'] ?? true,
        isAvailable: map['isAvailable'] ?? true,
        createdAt: map['createdAt'] != null
            ? DateTime.parse(map['createdAt'])
            : DateTime.now(),
      );
}
