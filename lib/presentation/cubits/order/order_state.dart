part of 'order_cubit.dart';

enum OrderStatus { initial, loading, loaded, error }

class OrderState {
  final OrderStatus status;
  final List<OrderEntity> orders;
  final String? errorMessage;

  const OrderState({
    this.status = OrderStatus.initial,
    this.orders = const [],
    this.errorMessage,
  });

  OrderState copyWith({
    OrderStatus? status,
    List<OrderEntity>? orders,
    String? errorMessage,
  }) {
    return OrderState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
} 