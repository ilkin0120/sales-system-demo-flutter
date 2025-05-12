import '../repositories/order_repository_interface.dart';

class DeleteOrderUseCase {
  final IOrderRepository repository;

  DeleteOrderUseCase(this.repository);

  Future<void> execute(int orderId) {
    return repository.deleteOrder(orderId);
  }
} 