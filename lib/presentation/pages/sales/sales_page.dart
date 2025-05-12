import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/domain/entities/order_entity.dart';

import '../../../core/di/dependency_injection.dart';
import '../../cubits/order/order_cubit.dart';
import '../../cubits/product/product_cubit.dart';
import 'widgets/bottom_navigation_bar.dart';
import 'widgets/custom_drawer.dart';
import 'widgets/orders_list.dart';

class SalesPage extends StatefulWidget {
  final String seatingTitle;
  final int seatingAreaId;

  const SalesPage({
    super.key,
    required this.seatingAreaId,
    required this.seatingTitle,
  });

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  // Метод для отображения диалога подтверждения
  Future<void> _showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Пользователь должен нажать на кнопку
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Подтверждение'),
          content: const Text(
              'Вы уверены, что хотите удалить все заказы для этого столика?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Удалить',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                // Вызываем метод удаления всех заказов
                context.read<OrderCubit>().deleteAllOrdersForCurrentTable();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final orders = context.select<OrderCubit, List<OrderEntity>>((cubit) => cubit.state.orders);
    
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          if (orders.isNotEmpty)
            IconButton(
                onPressed: _showConfirmationDialog,
                icon: const Icon(
                  Icons.cleaning_services_rounded,
                  color: Colors.red,
                ))
        ],
        title: Text(widget.seatingTitle),
      ),
      drawer: const CustomDrawer(),
      body: const OrdersList(),
      bottomNavigationBar: CustomBottomNavigationBar(
        seatingAreaId: widget.seatingAreaId,
        screenHeight: height,
      ),
    );
  }
}
