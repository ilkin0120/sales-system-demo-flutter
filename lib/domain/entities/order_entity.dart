import 'package:uuid/uuid.dart';

class OrderEntity {
  final String id;
  final int seatingAreaId;
  final int productId;
  final String productName;
  final double productPrice;
  final int quantity;

  OrderEntity({
    String? id,
    required this.seatingAreaId,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.quantity,
  }) : id = id ?? const Uuid().v4();
}
