import 'package:flutter/material.dart';
import 'package:test_task/src/screens/sales/widgets/bottom_navigation_bar.dart';
import 'package:test_task/src/screens/sales/widgets/custom_drawer.dart';
import 'package:test_task/src/screens/sales/widgets/orders_list.dart';

class SalesModeScreen extends StatefulWidget {
  final int seatingAreaId;

  const SalesModeScreen({super.key, required this.seatingAreaId});

  @override
  State<SalesModeScreen> createState() => _SalesModeScreenState();
}

class _SalesModeScreenState extends State<SalesModeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
          title: const Text('Режим продаж'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
        drawer: const CustomDrawer(),
        body: Column(
          children: [
            TabBar(
              controller: _tabController,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Theme.of(context).primaryColor,
              tabs: const [
                Tab(text: 'Товары (2300)'),
                Tab(text: 'Параметры'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  OrdersList(),
                  Center(child: Text('Раздел «Параметры»')),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          seatingAreaId: widget.seatingAreaId,
          screenHeight: height,
        ));
  }
}
