class CustomerOrder {
  final int? id;
  final int seatingAreaId;
  final String productName;
  final double productPrice;

  final int quantity;

  CustomerOrder(
      {this.id,
      required this.seatingAreaId,
      required this.productName,
      required this.productPrice,
      required this.quantity});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'seating_area_id': seatingAreaId,
      'product_name': productName,
      'product_price': productPrice,
      'quantity': quantity,
    };
  }

  factory CustomerOrder.fromMap(Map<String, dynamic> map) {
    return CustomerOrder(
      id: map['id'],
      seatingAreaId: map['seating_area_id'],
      productName: map['product_name'],
      productPrice: map['product_price'],
      quantity: map['quantity'],
    );
  }
}
