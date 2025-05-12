import 'package:flutter/material.dart';
import 'package:test_task/src/screens/sales/widgets/bottom_navigation_bar.dart';
import 'package:test_task/src/screens/sales/widgets/custom_drawer.dart';
import 'package:test_task/src/screens/sales/widgets/orders_list.dart';

class SalesModeScreen extends StatelessWidget {
  final String seatingTitle;
  final int seatingAreaId;

  const SalesModeScreen({super.key, required this.seatingAreaId,required this.seatingTitle});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
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
          title:  Text(seatingTitle),
        ),
        drawer: const CustomDrawer(),
        body: const OrdersList(),
        bottomNavigationBar: CustomBottomNavigationBar(
          seatingAreaId: seatingAreaId,
          screenHeight: height,
        ));
  }
}
