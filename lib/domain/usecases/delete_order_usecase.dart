import '../repositories/order_repository_interface.dart';

class DeleteOrderUseCase {
  final IOrderRepository repository;

  DeleteOrderUseCase(this.repository);

  Future<void> execute(String orderId) {
    return repository.deleteOrder(orderId);
  }
} 