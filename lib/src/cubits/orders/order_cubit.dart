import 'package:bloc/bloc.dart';
import 'package:test_task/src/data/models/customer_order.dart';
import 'package:test_task/src/data/repositories/order_repository.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final _orderRepository = OrderRepository();

  OrderCubit() : super(OrderState(orders: []));

  void getAllOrdersBySeatId(int seatId) async {
    final orders = await _orderRepository.getOrdersBySeatingId(seatId);
    emit(state.copyWith(orders: orders.reversed.toList()));
  }

  Future<void> addNewOrder(int productId, int seatingAreaId, String productName,
      double productPrice) async {
    await _orderRepository.addOrder(
      productId,
      seatingAreaId,
      productName,
      productPrice,
    );
    getAllOrdersBySeatId(seatingAreaId);
  }

  Future<void> incrementQuantity(int orderId) async {
    final updatedOrder = await _orderRepository.incrementQuantity(orderId);
    final updatedOrders = state.orders.map((order) {
      if (order.id == orderId) return updatedOrder;
      return order;
    }).toList();
    emit(OrderState(orders: updatedOrders));
  }

  Future<void> decrementQuantity(int orderId) async {
    final currentOrder =
        state.orders.firstWhere((order) => order.id == orderId);
    if (currentOrder.quantity > 1) {
      final updatedOrder = await _orderRepository.decrementQuantity(orderId);
      final updatedOrders = state.orders.map((order) {
        if (order.id == orderId) return updatedOrder;
        return order;
      }).toList();
      emit(OrderState(orders: updatedOrders));
    } else {
      await _orderRepository.deleteOrder(orderId);
      final updatedOrders =
          state.orders.where((order) => order.id != orderId).toList();
      emit(OrderState(orders: updatedOrders));
    }
  }
}
