class ProductEntity {
  final int? id;
  final int groupId;
  final String name;
  final double price;
  final int stock;
  final String imageUrl;

  const ProductEntity({
    this.id,
    required this.groupId,
    required this.name,
    required this.stock,
    required this.imageUrl,
    required this.price,
  });
} 