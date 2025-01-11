class ProductGroup {
  final int? id;
  final String name;

  ProductGroup({this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory ProductGroup.fromMap(Map<String, dynamic> map) {
    return ProductGroup(
      id: map['id'],
      name: map['name'],
    );
  }
}