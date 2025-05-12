import 'package:test_task/domain/entities/order_entity.dart';

import '../repositories/order_repository_interface.dart';

class AddOrderUseCase {
  final IOrderRepository repository;

  AddOrderUseCase(this.repository);

  List<OrderEntity> execute(List<OrderEntity> orders,int productId, int seatingAreaId, String productName, double price) {

     repository.addOrder(productId, seatingAreaId, productName, price);
     final newOrder = OrderEntity(
         seatingAreaId: seatingAreaId,
         productId: productId,
         productName: productName,
         productPrice: price,
         quantity: 1);
     final newList = List.of(orders);
     newList.insert(0, newOrder);
     return newList;
  }
}