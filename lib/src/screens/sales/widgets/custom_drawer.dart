import 'package:flutter/material.dart';
import 'package:test_task/src/route/route_names.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Шапка с пользователем
          Container(
            margin: const EdgeInsets.only(top: 40, left: 20),
            height: 80, // Задаём нужную высоту

            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              // Центрируем содержимое
              children: [
                Text(
                  'Иванов Иван Иванович',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Сотрудник',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          ListTile(
            leading: const Icon(Icons.sync, color: Colors.blue),
            title: const Text('Синхронизация'),
            subtitle: const Text('(19.04.2022 15:04)'),
            onTap: () {},
          ),
          ListTile(
            leading:
                const Icon(Icons.account_balance_wallet, color: Colors.blue),
            title: const Text('Кассир'),
            onTap: () => Navigator.pushNamed(context, RouteNames.cashierResult),
          ),
          ListTile(
            leading: const Icon(Icons.people, color: Colors.blue),
            title: const Text('Официант'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart, color: Colors.blue),
            title: const Text('Режим продаж'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.storage, color: Colors.blue),
            title: const Text('Склад'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.blue),
            title: const Text('Сменить сотрудника'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
