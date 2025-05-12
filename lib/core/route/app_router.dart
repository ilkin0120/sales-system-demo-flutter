import 'package:flutter/material.dart';

import '../../presentation/pages/cashier/cashier_page.dart';
import '../../presentation/pages/home/home_page.dart';
import '../../presentation/pages/sales/sales_page.dart';
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
          builder: (_) => const CashierPage(),
        );
    }
    return null;
  }
}