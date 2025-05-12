import '../../domain/entities/seating_area_entity.dart';

class SeatingAreaModel {
  final int? id;
  final String name;
  final int zoneId;

  const SeatingAreaModel({
    this.id,
    required this.name,
    required this.zoneId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'zone_id': zoneId,
    };
  }

  factory SeatingAreaModel.fromMap(Map<String, dynamic> map) {
    return SeatingAreaModel(
      id: map['id'],
      name: map['name'],
      zoneId: map['zone_id'],
    );
  }

  factory SeatingAreaModel.fromEntity(SeatingAreaEntity entity) {
    return SeatingAreaModel(
      id: entity.id,
      name: entity.name,
      zoneId: entity.zoneId,
    );
  }

  SeatingAreaEntity toEntity() {
    return SeatingAreaEntity(
      id: id,
      name: name,
      zoneId: zoneId,
    );
  }
} 