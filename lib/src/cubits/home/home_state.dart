part of 'home_cubit.dart';

class HomeState {
  Map<ZoneModel, List<SeatingArea>> zoneAndSeatingAreas;

  HomeState({required this.zoneAndSeatingAreas});

  HomeState copyWith({
    Map<ZoneModel, List<SeatingArea>>? zoneAndSeatingAreas,
  }) {
    return HomeState(
      zoneAndSeatingAreas: zoneAndSeatingAreas ?? this.zoneAndSeatingAreas,
    );
  }
}
