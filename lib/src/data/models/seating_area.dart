class SeatingArea {
  final int? id;
  final int zoneId;
  final String name;

  SeatingArea({this.id, required this.name, required this.zoneId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'zone_id': zoneId,
    };
  }

  factory SeatingArea.fromMap(Map<String, dynamic> map) {
    return SeatingArea(
      id: map['id'],
      name: map['name'],
      zoneId: map['zone_id'],
    );
  }
}
