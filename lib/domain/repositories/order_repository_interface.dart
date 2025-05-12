import '../entities/order_entity.dart';

abstract class IOrderRepository {
  Future<List<OrderEntity>> getOrdersBySeatingId(int seatId);
  Future<OrderEntity> incrementQuantity(int orderId);
  Future<OrderEntity> decrementQuantity(int orderId);
  Future<void> deleteOrder(int orderId);
  Future<void> addOrder(int productId, int seatingAreaId, String productName, double price);
} 