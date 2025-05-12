import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'order_entity.freezed.dart';

@freezed
abstract class OrderEntity with _$OrderEntity {
  const OrderEntity._();

  factory OrderEntity({
    @Default('') String id,
    required int seatingAreaId,
    required int productId,
    required String productName,
    required double productPrice,
    required int quantity,
  }) = _OrderEntity;

  factory OrderEntity.create({
    String? id,
    required int seatingAreaId,
    required int productId,
    required String productName,
    required double productPrice,
    required int quantity,
  }) {
    return OrderEntity(
      id: id ?? const Uuid().v4(),
      seatingAreaId: seatingAreaId,
      productId: productId,
      productName: productName,
      productPrice: productPrice,
      quantity: quantity,
    );
  }
}
