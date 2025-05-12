import '../entities/order_entity.dart';

abstract class IOrderRepository {
  Future<List<OrderEntity>> getOrdersBySeatingId(int seatId);

  Future<OrderEntity> incrementQuantity(String orderId);

  Future<OrderEntity> decrementQuantity(String orderId);

  Future<void> deleteOrder(String orderId);

  Future<void> addOrder(String id, int productId, int seatingAreaId,
      String productName, double price);
}
