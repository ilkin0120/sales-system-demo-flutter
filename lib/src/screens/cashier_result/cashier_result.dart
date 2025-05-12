import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/src/cubits/cashier/cashier_cubit.dart';
import 'package:test_task/core/route/route_names.dart';

class CashierResult extends StatelessWidget {
  const CashierResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Кассир'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<CashierCubit, CashierState>(builder: (context, state) {
        return ListView.builder(
          itemCount: state.seatsBills.length,
          itemBuilder: (context, index) {
            final bill = state.seatsBills[index];
            return ListTile(
              onTap: () => Navigator.pushNamed(context, RouteNames.sales,
                  arguments: {
                    'seatId': bill.seatId,
                    'seatingTitle': bill.seatName
                  }),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.document_scanner_outlined,
                  color: Colors.black,
                ),
              ),
              title: const Text(
                'Посетитель',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              subtitle: Text(
                bill.seatName,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '№${(index + 1).toString()}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    bill.total.toString(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          },
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Счета',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Отчёты',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: 'Смена',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }
}
