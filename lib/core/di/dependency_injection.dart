import 'package:get_it/get_it.dart';

import '../../data/datasources/local/cashier_local_data_source.dart';
import '../../data/datasources/local/db_helper.dart';
import '../../data/datasources/local/home_local_data_source.dart';
import '../../data/datasources/local/order_local_data_source.dart';
import '../../data/datasources/local/product_local_data_source.dart';
import '../../data/repositories/cashier_repository_impl.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../data/repositories/order_repository_impl.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/repositories/cashier_repository_interface.dart';
import '../../domain/repositories/home_repository_interface.dart';
import '../../domain/repositories/order_repository_interface.dart';
import '../../domain/repositories/product_repository_interface.dart';
import '../../domain/usecases/add_order_usecase.dart';
import '../../domain/usecases/decrement_quantity_usecase.dart';
import '../../domain/usecases/delete_order_usecase.dart';
import '../../domain/usecases/get_bills_usecase.dart';
import '../../domain/usecases/get_orders_by_seating_id_usecase.dart';
import '../../domain/usecases/get_product_groups_usecase.dart';
import '../../domain/usecases/get_products_by_group_usecase.dart';
import '../../domain/usecases/get_seating_areas_by_zone_usecase.dart';
import '../../domain/usecases/get_zones_usecase.dart';
import '../../domain/usecases/increment_quantity_usecase.dart';
import '../../presentation/cubits/cashier/cashier_cubit.dart';
import '../../presentation/cubits/home/home_cubit.dart';
import '../../presentation/cubits/order/order_cubit.dart';
import '../../presentation/cubits/product/product_cubit.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Database
  getIt.registerLazySingleton<DbHelper>(() => DbHelper());

  // DataSources
  getIt.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(dbHelper: getIt()),
  );
  getIt.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(dbHelper: getIt()),
  );
  getIt.registerLazySingleton<OrderLocalDataSource>(
    () => OrderLocalDataSourceImpl(dbHelper: getIt()),
  );
  getIt.registerLazySingleton<CashierLocalDataSource>(
    () => CashierLocalDataSourceImpl(dbHelper: getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<IHomeRepository>(
    () => HomeRepositoryImpl(localDataSource: getIt()),
  );
  getIt.registerLazySingleton<IProductRepository>(
    () => ProductRepositoryImpl(localDataSource: getIt()),
  );
  getIt.registerLazySingleton<IOrderRepository>(
    () => OrderRepositoryImpl(localDataSource: getIt()),
  );
  getIt.registerLazySingleton<ICashierRepository>(
    () => CashierRepositoryImpl(localDataSource: getIt()),
  );

  // UseCases
  getIt.registerLazySingleton<GetZonesUseCase>(
    () => GetZonesUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetSeatingAreasByZoneUseCase>(
    () => GetSeatingAreasByZoneUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetProductGroupsUseCase>(
    () => GetProductGroupsUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetProductsByGroupUseCase>(
    () => GetProductsByGroupUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetOrdersBySeatingIdUseCase>(
    () => GetOrdersBySeatingIdUseCase(getIt()),
  );
  getIt.registerLazySingleton<AddOrderUseCase>(
    () => AddOrderUseCase(getIt()),
  );
  getIt.registerLazySingleton<IncrementQuantityUseCase>(
    () => IncrementQuantityUseCase(getIt()),
  );
  getIt.registerLazySingleton<DecrementQuantityUseCase>(
    () => DecrementQuantityUseCase(getIt()),
  );
  getIt.registerLazySingleton<DeleteOrderUseCase>(
    () => DeleteOrderUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetBillsUseCase>(
    () => GetBillsUseCase(getIt()),
  );

  // Cubits
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(
      getZonesUseCase: getIt(),
      getSeatingAreasByZoneUseCase: getIt(),
    ),
  );
  getIt.registerFactory<ProductCubit>(
    () => ProductCubit(
      getProductGroupsUseCase: getIt(),
      getProductsByGroupUseCase: getIt(),
    ),
  );
  getIt.registerFactory<OrderCubit>(
    () => OrderCubit(
      getOrdersBySeatingIdUseCase: getIt(),
      addOrderUseCase: getIt(),
      incrementQuantityUseCase: getIt(),
      decrementQuantityUseCase: getIt(),
      deleteOrderUseCase: getIt(),
    ),
  );
  getIt.registerFactory<CashierCubit>(
    () => CashierCubit(
      getBillsUseCase: getIt(),
    ),
  );
} 