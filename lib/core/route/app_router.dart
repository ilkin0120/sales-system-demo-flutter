import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/cubits/cashier/cashier_cubit.dart';
import '../../presentation/cubits/home/home_cubit.dart';
import '../../presentation/cubits/order/order_cubit.dart';
import '../../presentation/cubits/product/product_cubit.dart';
import '../../presentation/pages/cashier/cashier_page.dart';
import '../../presentation/pages/home/home_page.dart';
import '../../presentation/pages/sales/sales_page.dart';
import '../di/dependency_injection.dart';
import 'custom_page_router.dart';
import 'route_names.dart';

class AppRouter {
  List<BlocProvider> get globalProviders => [
        BlocProvider<HomeCubit>(
          create: (_) => getIt<HomeCubit>(),
        ),
        BlocProvider<ProductCubit>(
          create: (_) => getIt<ProductCubit>(),
        ),
        BlocProvider<OrderCubit>(
          create: (_) => getIt<OrderCubit>(),
        ),
        BlocProvider<CashierCubit>(
          create: (_) => getIt<CashierCubit>(),
        ),
      ];

  Widget _wrapWithProviders(Widget page) {
    return MultiBlocProvider(
      providers: globalProviders,
      child: page,
    );
  }

  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.home:
        return CustomPageRoute(
          builder: (_) => _wrapWithProviders(const HomePage()),
        );
      case RouteNames.sales:
        final arguments = routeSettings.arguments as Map;
        final int seatingAreaId = arguments['seatId'];
        final String seatingTitle = arguments['seatingTitle'];

        // Инициализация кубитов для SalesPage
        final orderCubit = getIt<OrderCubit>();
        final productCubit = getIt<ProductCubit>();

        // Предварительная загрузка данных
        orderCubit.getAllOrdersBySeatId(seatingAreaId);
        productCubit.getAllData();

        return CustomPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: orderCubit),
              BlocProvider.value(value: productCubit),
            ],
            child: SalesPage(
              seatingAreaId: seatingAreaId,
              seatingTitle: seatingTitle,
            ),
          ),
        );
      case RouteNames.cashierResult:
        return CustomPageRoute(
          builder: (_) => _wrapWithProviders(const CashierPage()),
        );
    }
    return null;
  }
}
