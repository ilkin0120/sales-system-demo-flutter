import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/order_repository_interface.dart';
import '../datasources/local/order_local_data_source.dart';

class OrderRepositoryImpl implements IOrderRepository {
  final OrderLocalDataSource localDataSource;

  OrderRepositoryImpl({required this.localDataSource});

  @override
  Future<List<OrderEntity>> getOrdersBySeatingId(int seatId) async {
    final orderModels = await localDataSource.getOrdersBySeatingId(seatId);
    return orderModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<OrderEntity> incrementQuantity(String orderId) async {
    final orderModel = await localDataSource.incrementQuantity(orderId);
    return orderModel.toEntity();
  }

  @override
  Future<OrderEntity> decrementQuantity(String orderId) async {
    final orderModel = await localDataSource.decrementQuantity(orderId);
    return orderModel.toEntity();
  }

  @override
  Future<void> deleteOrder(String orderId) {
    return localDataSource.deleteOrder(orderId);
  }

  @override
  Future<void> addOrder(int productId, int seatingAreaId, String productName, double price) {
    return localDataSource.addOrder(productId, seatingAreaId, productName, price);
  }
} 