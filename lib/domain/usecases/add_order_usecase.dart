import 'package:test_task/domain/entities/order_entity.dart';

import '../repositories/order_repository_interface.dart';

class AddOrderUseCase {
  final IOrderRepository repository;

  AddOrderUseCase(this.repository);

  List<OrderEntity> execute(List<OrderEntity> orders, int productId,
      int seatingAreaId, String productName, double price) {
    final existingOrderIndex = orders.indexWhere((order) =>
        order.productId == productId && order.seatingAreaId == seatingAreaId);

    final newList = List.of(orders);

    if (existingOrderIndex != -1) {
      final existingOrder = orders[existingOrderIndex];
      final updatedOrder =
          existingOrder.copyWith(quantity: existingOrder.quantity + 1);

      repository.incrementQuantity(updatedOrder.id);

      newList[existingOrderIndex] = updatedOrder;
    } else {
      final newOrder = OrderEntity.create(
          seatingAreaId: seatingAreaId,
          productId: productId,
          productName: productName,
          productPrice: price,
          quantity: 1);

      repository.addOrder(
          newOrder.id, productId, seatingAreaId, productName, price);

      newList.insert(0, newOrder);
    }

    return newList;
  }
}
