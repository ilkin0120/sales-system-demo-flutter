import '../repositories/order_repository_interface.dart';

class AddOrderUseCase {
  final IOrderRepository repository;

  AddOrderUseCase(this.repository);

  Future<void> execute(int productId, int seatingAreaId, String productName, double price) {
    return repository.addOrder(productId, seatingAreaId, productName, price);
  }
}