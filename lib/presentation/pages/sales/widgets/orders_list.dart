import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/order/order_cubit.dart';
import 'product_item.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        if (state.status == OrderStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == OrderStatus.error) {
          return Center(child: Text('Ошибка: ${state.errorMessage}'));
        } else if (state.orders.isEmpty) {
          return const Center(child: Text('Нет заказов'));
        }
        
        return ListView.separated(
          itemCount: state.orders.length,
          itemBuilder: (context, index) {
            final order = state.orders[index];
            return ProductItem(
              onPlusClick: () => context.read<OrderCubit>().incrementQuantity(order.id!),
              onMinusClick: () => context.read<OrderCubit>().decrementQuantity(order.id!),
              name: order.productName,
              price: order.productPrice,
              quantity: order.quantity,
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 15);
          },
        );
      },
    );
  }
} 