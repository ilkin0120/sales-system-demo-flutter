import '../entities/zone_entity.dart';
import '../repositories/home_repository_interface.dart';

class GetZonesUseCase {
  final IHomeRepository repository;

  GetZonesUseCase(this.repository);

  Future<List<ZoneEntity>> execute() {
    return repository.getZones();
  }
}
