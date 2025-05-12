part of 'home_cubit.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeState {
  final HomeStatus status;
  final Map<ZoneEntity, List<SeatingAreaEntity>> zoneAndSeatingAreas;
  final String? errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.zoneAndSeatingAreas = const {},
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
    Map<ZoneEntity, List<SeatingAreaEntity>>? zoneAndSeatingAreas,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      zoneAndSeatingAreas: zoneAndSeatingAreas ?? this.zoneAndSeatingAreas,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
} 