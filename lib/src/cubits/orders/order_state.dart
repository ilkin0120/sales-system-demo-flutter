part of 'order_cubit.dart';



class OrderState {
  List<CustomerOrder> orders;

  OrderState({required this.orders});

  OrderState copyWith({List<CustomerOrder>? orders}) {
    return OrderState(orders: orders ?? this.orders);
  }
}


