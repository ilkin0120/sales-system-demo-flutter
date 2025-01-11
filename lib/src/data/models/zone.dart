class ZoneModel {
  final int? id;
  final String name;

  ZoneModel({this.id, required this.name});

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
}
