import 'package:bloc/bloc.dart';

import '../../../domain/entities/order_entity.dart';
import '../../../domain/usecases/add_order_usecase.dart';
import '../../../domain/usecases/decrement_quantity_usecase.dart';
import '../../../domain/usecases/delete_order_usecase.dart';
import '../../../domain/usecases/get_orders_by_seating_id_usecase.dart';
import '../../../domain/usecases/increment_quantity_usecase.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final GetOrdersBySeatingIdUseCase _getOrdersBySeatingIdUseCase;
  final AddOrderUseCase _addOrderUseCase;
  final IncrementQuantityUseCase _incrementQuantityUseCase;
  final DecrementQuantityUseCase _decrementQuantityUseCase;
  final DeleteOrderUseCase _deleteOrderUseCase;

  OrderCubit({
    required GetOrdersBySeatingIdUseCase getOrdersBySeatingIdUseCase,
    required AddOrderUseCase addOrderUseCase,
    required IncrementQuantityUseCase incrementQuantityUseCase,
    required DecrementQuantityUseCase decrementQuantityUseCase,
    required DeleteOrderUseCase deleteOrderUseCase,
  })  : _getOrdersBySeatingIdUseCase = getOrdersBySeatingIdUseCase,
        _addOrderUseCase = addOrderUseCase,
        _incrementQuantityUseCase = incrementQuantityUseCase,
        _decrementQuantityUseCase = decrementQuantityUseCase,
        _deleteOrderUseCase = deleteOrderUseCase,
        super(const OrderState());

  Future<void> getAllOrdersBySeatId(int seatId) async {
    emit(state.copyWith(status: OrderStatus.loading));

    try {
      final orders = await _getOrdersBySeatingIdUseCase.execute(seatId);
      emit(state.copyWith(
        status: OrderStatus.loaded,
        orders: orders.reversed.toList(),
      ));
    } catch (e) {
      emit(state.copyWith(
        status: OrderStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void addNewOrder(int productId, int seatingAreaId, String productName,
      double productPrice) {
    try {
      final newList = _addOrderUseCase.execute(
        state.orders,
        productId,
        seatingAreaId,
        productName,
        productPrice,
      );

      emit(state.copyWith(
        orders: newList,
        status: OrderStatus.loaded,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: OrderStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> incrementQuantity(String orderId) async {
    try {
      final updatedOrder = await _incrementQuantityUseCase.execute(orderId);
      final updatedOrders = state.orders.map((order) {
        if (order.id == orderId) return updatedOrder;
        return order;
      }).toList();

      emit(state.copyWith(orders: updatedOrders));
    } catch (e) {
      emit(state.copyWith(
        status: OrderStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> decrementQuantity(String orderId) async {
    try {
      final currentOrder =
          state.orders.firstWhere((order) => order.id == orderId);

      if (currentOrder.quantity > 1) {
        final updatedOrder = await _decrementQuantityUseCase.execute(orderId);
        final updatedOrders = state.orders.map((order) {
          if (order.id == orderId) return updatedOrder;
          return order;
        }).toList();

        emit(state.copyWith(orders: updatedOrders));
      } else {
        await _deleteOrderUseCase.execute(orderId);
        final updatedOrders =
            state.orders.where((order) => order.id != orderId).toList();

        emit(state.copyWith(orders: updatedOrders));
      }
    } catch (e) {
      emit(state.copyWith(
        status: OrderStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
