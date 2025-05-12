import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/di/dependency_injection.dart';
import '../../presentation/cubits/order/order_cubit.dart';
import '../../presentation/cubits/product/product_cubit.dart';
import '../../presentation/pages/home/home_page.dart';
import '../../presentation/pages/sales/sales_page.dart';
import '../../src/cubits/cashier/cashier_cubit.dart';
import '../../src/screens/cashier_result/cashier_result.dart';
import 'custom_page_router.dart';
import 'route_names.dart';

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
          builder: (_) => SalesPage(
            seatingAreaId: arguments['seatId'],
            seatingTitle: arguments['seatingTitle'],
          ),
        );
      case RouteNames.cashierResult:
        return CustomPageRoute(
          builder: (_) => BlocProvider<CashierCubit>(
            create: (_) => CashierCubit()..getAllBills(),
            child: const CashierResult(),
          ),
        );
    }
    return null;
  }
} 