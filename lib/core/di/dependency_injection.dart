import 'package:get_it/get_it.dart';

import '../../data/datasources/local/db_helper.dart';
import '../../data/datasources/local/home_local_data_source.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/repositories/home_repository_interface.dart';
import '../../domain/usecases/get_seating_areas_by_zone_usecase.dart';
import '../../domain/usecases/get_zones_usecase.dart';
import '../../presentation/cubits/home/home_cubit.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Database
  getIt.registerLazySingleton<DbHelper>(() => DbHelper());

  // DataSources
  getIt.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(dbHelper: getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<IHomeRepository>(
    () => HomeRepositoryImpl(localDataSource: getIt()),
  );

  // UseCases
  getIt.registerLazySingleton<GetZonesUseCase>(
    () => GetZonesUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetSeatingAreasByZoneUseCase>(
    () => GetSeatingAreasByZoneUseCase(getIt()),
  );

  // Cubits
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(
      getZonesUseCase: getIt(),
      getSeatingAreasByZoneUseCase: getIt(),
    ),
  );
} 