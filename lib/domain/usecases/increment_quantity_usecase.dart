import '../entities/order_entity.dart';
import '../repositories/order_repository_interface.dart';

class IncrementQuantityUseCase {
  final IOrderRepository repository;

  IncrementQuantityUseCase(this.repository);

  Future<OrderEntity> execute(String orderId) {
    return repository.incrementQuantity(orderId);
  }
}
