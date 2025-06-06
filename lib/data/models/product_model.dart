import '../../domain/entities/product_entity.dart';

class ProductModel {
  final int? id;
  final int groupId;
  final String name;
  final int stock;
  final String imageUrl;
  final double price;

  const ProductModel({
    this.id,
    required this.groupId,
    required this.name,
    required this.stock,
    required this.imageUrl,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category_id': groupId,
      'name': name,
      'price': price,
      'stock': stock,
      'imageUrl': imageUrl,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      groupId: map['category_id'],
      name: map['name'],
      imageUrl: map['imageUrl'],
      stock: map['stock'],
      price: map['price'],
    );
  }

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      groupId: entity.groupId,
      name: entity.name,
      stock: entity.stock,
      imageUrl: entity.imageUrl,
      price: entity.price,
    );
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      groupId: groupId,
      name: name,
      stock: stock,
      imageUrl: imageUrl,
      price: price,
    );
  }
} 