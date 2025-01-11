import 'package:bloc/bloc.dart';
import 'package:test_task/src/data/models/seating_area.dart';

import '../../data/models/zone.dart';
import '../../data/repositories/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final _homeRepository = HomeRepository();

  HomeCubit() : super(HomeState(zoneAndSeatingAreas: {}));

  void getAllData() async {
    Map<ZoneModel, List<SeatingArea>> result = {};
    final zones = await _homeRepository.fetchZones();
    for (final zone in zones) {
      final areas = await _homeRepository.fetchSeatingAreasByZone(zone.id!);
      result[zone] = areas;
    }
    emit(state.copyWith(zoneAndSeatingAreas: result));
  }
}
