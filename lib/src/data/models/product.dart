class Product {
  final int? id;
  final int groupId;
  final String name;
  final double price;
  final int stock;
  final String imageUrl;

  Product(
      {this.id,
      required this.groupId,
      required this.name,
      required this.stock,
      required this.imageUrl,
      required this.price});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category_id': groupId,
      'name': name,
      'price': price,
      'stock': stock,
      'imageUrl': imageUrl,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      groupId: map['category_id'],
      name: map['name'],
      imageUrl: map['imageUrl'],
      stock: map['stock'],
      price: map['price'],
    );
  }
}
