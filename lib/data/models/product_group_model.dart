import '../../domain/entities/product_group_entity.dart';

class ProductGroupModel extends ProductGroupEntity {
  const ProductGroupModel({
    super.id,
    required super.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory ProductGroupModel.fromMap(Map<String, dynamic> map) {
    return ProductGroupModel(
      id: map['id'],
      name: map['name'],
    );
  }

  factory ProductGroupModel.fromEntity(ProductGroupEntity entity) {
    return ProductGroupModel(
      id: entity.id,
      name: entity.name,
    );
  }

  ProductGroupEntity toEntity() {
    return ProductGroupEntity(
      id: id,
      name: name,
    );
  }
} 