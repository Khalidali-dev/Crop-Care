class ProductModel {
  final String id;
  final String name;
  final String category;
  final double price;
  final int stock;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  // ================= TO MAP =================
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'price': price,
      'stock': stock,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // ================= FROM MAP =================
  factory ProductModel.fromMap(
      Map<String, dynamic> map,
      String id,
      ) {
    return ProductModel(
      id: id,
      name: map['name'] ?? '',
      category: map['category'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      stock: (map['stock'] ?? 0).toInt(),
      isActive: map['isActive'] ?? true,
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ??
          DateTime.now(),
      updatedAt: DateTime.tryParse(map['updatedAt'] ?? '') ??
          DateTime.now(),
    );
  }
}
