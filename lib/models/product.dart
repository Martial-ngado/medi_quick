class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String imageUrl;
  final bool requiresPrescription;
  final int stock;
  final String pharmacyId;
  final String manufacturer;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.requiresPrescription,
    required this.stock,
    required this.pharmacyId,
    required this.manufacturer,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      category: json['category'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      requiresPrescription: json['requiresPrescription'] ?? false,
      stock: json['stock'] ?? 0,
      pharmacyId: json['pharmacyId'] ?? '',
      manufacturer: json['manufacturer'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'imageUrl': imageUrl,
      'requiresPrescription': requiresPrescription,
      'stock': stock,
      'pharmacyId': pharmacyId,
      'manufacturer': manufacturer,
    };
  }
}
