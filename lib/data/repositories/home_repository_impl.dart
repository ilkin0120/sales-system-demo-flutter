import '../../domain/entities/seating_area_entity.dart';
import '../../domain/entities/zone_entity.dart';
import '../../domain/repositories/home_repository_interface.dart';
import '../datasources/local/home_local_data_source.dart';

class HomeRepositoryImpl implements IHomeRepository {
  final HomeLocalDataSource localDataSource;

  HomeRepositoryImpl({required this.localDataSource});

  @override
  Future<List<SeatingAreaEntity>> getSeatingAreasByZone(int zoneId) async {
    final seatingAreaModels = await localDataSource.getSeatingAreasByZone(zoneId);
    return seatingAreaModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<ZoneEntity>> getZones() async {
    final zoneModels = await localDataSource.getZones();
    return zoneModels.map((model) => model.toEntity()).toList();
  }
} 