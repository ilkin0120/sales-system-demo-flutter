import 'package:bloc/bloc.dart';

import '../../../core/services/bill_update_service.dart';
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
  final BillUpdateService _billUpdateService;
  int? _currentSeatingAreaId;

  OrderCubit({
    required GetOrdersBySeatingIdUseCase getOrdersBySeatingIdUseCase,
    required AddOrderUseCase addOrderUseCase,
    required IncrementQuantityUseCase incrementQuantityUseCase,
    required DecrementQuantityUseCase decrementQuantityUseCase,
    required DeleteOrderUseCase deleteOrderUseCase,
    required BillUpdateService billUpdateService,
  })  : _getOrdersBySeatingIdUseCase = getOrdersBySeatingIdUseCase,
        _addOrderUseCase = addOrderUseCase,
        _incrementQuantityUseCase = incrementQuantityUseCase,
        _decrementQuantityUseCase = decrementQuantityUseCase,
        _deleteOrderUseCase = deleteOrderUseCase,
        _billUpdateService = billUpdateService,
        super(const OrderState());

  Future<void> getAllOrdersBySeatId(int seatId) async {
    emit(state.copyWith(status: OrderStatus.loading));
    _currentSeatingAreaId = seatId;

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

  bool get hasOrders => state.orders.isNotEmpty;

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

      // Обновляем общую сумму счета
      _updateTotalBill(seatingAreaId);
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

      // Обновляем общую сумму счета
      if (_currentSeatingAreaId != null) {
        _updateTotalBill(_currentSeatingAreaId!);
      }
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

      // Обновляем общую сумму счета
      if (_currentSeatingAreaId != null) {
        _updateTotalBill(_currentSeatingAreaId!);
      }
    } catch (e) {
      emit(state.copyWith(
        status: OrderStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  // Метод для расчета общей суммы счета и отправки обновления
  void _updateTotalBill(int seatingAreaId) {
    double total = 0;

    for (final order in state.orders) {
      if (order.seatingAreaId == seatingAreaId) {
        total += order.productPrice * order.quantity;
      }
    }

    // Отправляем обновление через сервис
    _billUpdateService.updateBill(seatingAreaId, total);
  }

  // Метод для удаления всех заказов текущего столика
  void deleteAllOrdersForCurrentTable() {
    if (_currentSeatingAreaId == null) return;

    try {
      final ordersToDelete = state.orders
          .where((order) => order.seatingAreaId == _currentSeatingAreaId)
          .toList();

      for (final order in ordersToDelete) {
        _deleteOrderUseCase.execute(order.id);
      }

      final updatedOrders = state.orders
          .where((order) => order.seatingAreaId != _currentSeatingAreaId)
          .toList();

      emit(state.copyWith(
        status: OrderStatus.loaded,
        orders: updatedOrders,
      ));

      _billUpdateService.updateBill(_currentSeatingAreaId!, 0);
    } catch (e) {
      emit(state.copyWith(
        status: OrderStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
