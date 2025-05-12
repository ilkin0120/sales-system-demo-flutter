import '../entities/order_entity.dart';
import '../repositories/order_repository_interface.dart';

class GetOrdersBySeatingIdUseCase {
  final IOrderRepository repository;

  GetOrdersBySeatingIdUseCase(this.repository);

  Future<List<OrderEntity>> execute(int seatingId) {
    return repository.getOrdersBySeatingId(seatingId);
  }
} 