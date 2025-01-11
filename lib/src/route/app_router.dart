import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/src/cubits/cashier/cashier_cubit.dart';
import 'package:test_task/src/cubits/home/home_cubit.dart';
import 'package:test_task/src/cubits/orders/order_cubit.dart';
import 'package:test_task/src/cubits/sales/product_cubit.dart';
import 'package:test_task/src/route/route_names.dart';
import 'package:test_task/src/screens/cashier_result/cashier_result.dart';
import 'package:test_task/src/screens/sales/sales.dart';

import '../screens/home/home.dart';
import 'custom_page_router.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.home:
        return CustomPageRoute(builder: (_) => BlocProvider<HomeCubit>(create: (_)=>HomeCubit()..getAllData(),child: const Home(),));
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
                    )));
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
