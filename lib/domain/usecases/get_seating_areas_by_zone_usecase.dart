import '../entities/seating_area_entity.dart';
import '../repositories/home_repository_interface.dart';

class GetSeatingAreasByZoneUseCase {
  final IHomeRepository repository;

  GetSeatingAreasByZoneUseCase(this.repository);

  Future<List<SeatingAreaEntity>> execute(int zoneId) {
    return repository.getSeatingAreasByZone(zoneId);
  }
} 