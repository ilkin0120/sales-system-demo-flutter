class OrderEntity {
  final int? id;
  final int seatingAreaId;
  final int productId;
  final String productName;
  final double productPrice;
  final int quantity;

  const OrderEntity({
    this.id,
    required this.seatingAreaId,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.quantity,
  });
} 