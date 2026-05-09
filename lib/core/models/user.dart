enum UserRole { customer, rider, vendor }

class User {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String? photoUrl;
  final UserRole role;
  final String? address;
  final double? lat;
  final double? lng;
  final bool isAvailable;
  final DateTime createdAt;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    this.photoUrl,
    required this.role,
    this.address,
    this.lat,
    this.lng,
    this.isAvailable = true,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() => {
        'id': id,
        'email': email,
        'name': name,
        'phone': phone,
        'photoUrl': photoUrl,
        'role': role.name,
        'address': address,
        'lat': lat,
        'lng': lng,
        'isAvailable': isAvailable,
        'createdAt': createdAt.toIso8601String(),
      };

  factory User.fromMap(Map<String, dynamic> map) => User(
        id: map['id'],
        email: map['email'],
        name: map['name'],
        phone: map['phone'],
        photoUrl: map['photoUrl'],
        role: UserRole.values.firstWhere((r) => r.name == map['role']),
        address: map['address'],
        lat: (map['lat'] as num?)?.toDouble(),
        lng: (map['lng'] as num?)?.toDouble(),
        isAvailable: map['isAvailable'] ?? true,
        createdAt: map['createdAt'] != null
            ? DateTime.parse(map['createdAt'])
            : DateTime.now(),
      );
}
