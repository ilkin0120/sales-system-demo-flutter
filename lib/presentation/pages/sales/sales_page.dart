import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  late OrderCubit _orderCubit;
  late ProductCubit _productCubit;

  @override
  void initState() {
    super.initState();
    _orderCubit = getIt<OrderCubit>();
    _productCubit = getIt<ProductCubit>();
    
    _orderCubit.getAllOrdersBySeatId(widget.seatingAreaId);
    _productCubit.getAllData();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _orderCubit),
        BlocProvider.value(value: _productCubit),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          title: Text(widget.seatingTitle),
        ),
        drawer: const CustomDrawer(),
        body: const OrdersList(),
        bottomNavigationBar: CustomBottomNavigationBar(
          seatingAreaId: widget.seatingAreaId,
          screenHeight: height,
        ),
      ),
    );
  }
} 