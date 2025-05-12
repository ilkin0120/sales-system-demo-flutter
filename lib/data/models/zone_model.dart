import '../../domain/entities/zone_entity.dart';

class ZoneModel {
  final int? id;
  final String name;

  const ZoneModel({
    this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory ZoneModel.fromMap(Map<String, dynamic> map) {
    return ZoneModel(
      id: map['id'],
      name: map['name'],
    );
  }

  factory ZoneModel.fromEntity(ZoneEntity entity) {
    return ZoneModel(
      id: entity.id,
      name: entity.name,
    );
  }

  ZoneEntity toEntity() {
    return ZoneEntity(
      id: id,
      name: name,
    );
  }
} 