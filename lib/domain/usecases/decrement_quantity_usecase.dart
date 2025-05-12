import '../entities/order_entity.dart';
import '../repositories/order_repository_interface.dart';

class DecrementQuantityUseCase {
  final IOrderRepository repository;

  DecrementQuantityUseCase(this.repository);

  Future<OrderEntity> execute(int orderId) {
    return repository.decrementQuantity(orderId);
  }
} 