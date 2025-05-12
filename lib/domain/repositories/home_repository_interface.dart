import '../entities/seating_area_entity.dart';
import '../entities/zone_entity.dart';

abstract class IHomeRepository {
  Future<List<ZoneEntity>> getZones();
  Future<List<SeatingAreaEntity>> getSeatingAreasByZone(int zoneId);
} 