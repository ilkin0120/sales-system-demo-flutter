import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/pages/home/home_page.dart';
import '../../src/cubits/cashier/cashier_cubit.dart';
import '../../src/cubits/orders/order_cubit.dart';
import '../../src/cubits/sales/product_cubit.dart';
import 'route_names.dart';
import '../../src/screens/cashier_result/cashier_result.dart';
import '../../src/screens/sales/sales.dart';
import 'custom_page_router.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.home:
        return CustomPageRoute(
          builder: (_) => const HomePage(),
        );
      case RouteNames.sales:
        final arguments = routeSettings.arguments as Map;
        return CustomPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider<ProductCubit>(
                      create: (_) => ProductCubit()..getAllData(),
                    ),
                    BlocProvider<OrderCubit>(
                      create: (_) => OrderCubit()
                        ..getAllOrdersBySeatId(arguments['seatId']),
                    )
                  ],
                  child: SalesModeScreen(
                    seatingAreaId: arguments['seatId'],
                    seatingTitle: arguments['seatingTitle'],
                  ),
                ));
      case RouteNames.cashierResult:
        return CustomPageRoute(
            builder: (_) => BlocProvider<CashierCubit>(
                  create: (_) => CashierCubit()..getAllBills(),
                  child: const CashierResult(),
                ));
    }
    return null;
  }
} 