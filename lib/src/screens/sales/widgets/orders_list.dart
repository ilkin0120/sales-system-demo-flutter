import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/orders/order_cubit.dart';
import 'product_item.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(builder: (context, state) {
      return ListView.separated(
        itemCount: state.orders.length,
        itemBuilder: (context, index) {
          final order = state.orders[index];
          return ProductItem(
              onPlusClick: () => context
                  .read<OrderCubit>()
                  .incrementQuantity(state.orders[index].id!),
              onMinusClick: () => context
                  .read<OrderCubit>()
                  .decrementQuantity(state.orders[index].id!),
              name: order.productName,
              price: order.productPrice,
              quantity: order.quantity);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 15,
          );
        },
      );
    });
  }
}
