import '../../domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    super.id,
    required super.seatingAreaId,
    required super.productId,
    required super.productName,
    required super.productPrice,
    required super.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'seating_area_id': seatingAreaId,
      'product_id': productId,
      'product_name': productName,
      'product_price': productPrice,
      'quantity': quantity,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'],
      seatingAreaId: map['seating_area_id'],
      productId: map['product_id'],
      productName: map['product_name'],
      productPrice: map['product_price'],
      quantity: map['quantity'],
    );
  }

  factory OrderModel.fromEntity(OrderEntity entity) {
    return OrderModel(
      id: entity.id,
      seatingAreaId: entity.seatingAreaId,
      productId: entity.productId,
      productName: entity.productName,
      productPrice: entity.productPrice,
      quantity: entity.quantity,
    );
  }

  OrderEntity toEntity() {
    return OrderEntity(
      id: id,
      seatingAreaId: seatingAreaId,
      productId: productId,
      productName: productName,
      productPrice: productPrice,
      quantity: quantity,
    );
  }
} 