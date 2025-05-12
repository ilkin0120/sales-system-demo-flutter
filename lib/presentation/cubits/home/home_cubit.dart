import 'package:bloc/bloc.dart';

import '../../../domain/entities/seating_area_entity.dart';
import '../../../domain/entities/zone_entity.dart';
import '../../../domain/usecases/get_seating_areas_by_zone_usecase.dart';
import '../../../domain/usecases/get_zones_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetZonesUseCase _getZonesUseCase;
  final GetSeatingAreasByZoneUseCase _getSeatingAreasByZoneUseCase;

  HomeCubit({
    required GetZonesUseCase getZonesUseCase,
    required GetSeatingAreasByZoneUseCase getSeatingAreasByZoneUseCase,
  })  : _getZonesUseCase = getZonesUseCase,
        _getSeatingAreasByZoneUseCase = getSeatingAreasByZoneUseCase,
        super(const HomeState());

  Future<void> getAllData() async {
    emit(state.copyWith(status: HomeStatus.loading));
    
    try {
      Map<ZoneEntity, List<SeatingAreaEntity>> result = {};
      final zones = await _getZonesUseCase.execute();
      
      for (final zone in zones) {
        final areas = await _getSeatingAreasByZoneUseCase.execute(zone.id!);
        result[zone] = areas;
      }
      
      emit(state.copyWith(
        status: HomeStatus.loaded,
        zoneAndSeatingAreas: result,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HomeStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
} 