import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import '../../models/order_model.dart';
import 'db_helper.dart';

abstract class OrderLocalDataSource {
  Future<List<OrderModel>> getOrdersBySeatingId(int seatId);
  Future<OrderModel> incrementQuantity(String orderId);
  Future<OrderModel> decrementQuantity(String orderId);
  Future<void> deleteOrder(String orderId);
  Future<void> addOrder(int productId, int seatingAreaId, String productName, double price);
}

class OrderLocalDataSourceImpl implements OrderLocalDataSource {
  final DbHelper dbHelper;

  OrderLocalDataSourceImpl({required this.dbHelper});

  @override
  Future<List<OrderModel>> getOrdersBySeatingId(int seatId) async {
    Database db = await dbHelper.database;
    var result = await db.query('customer_order',
        where: 'seating_area_id = ?', whereArgs: [seatId]);
    return result.map((json) => OrderModel.fromMap(json)).toList();
  }

  @override
  Future<OrderModel> incrementQuantity(String orderId) async {
    Database db = await dbHelper.database;
    await db.rawUpdate('''
      UPDATE customer_order
      SET quantity = quantity + 1
      WHERE id = ?
    ''', [orderId]);

    final result = await db.query(
      'customer_order',
      where: 'id = ?',
      whereArgs: [orderId],
    );
    return OrderModel.fromMap(result.first);
  }

  @override
  Future<OrderModel> decrementQuantity(String orderId) async {
    Database db = await dbHelper.database;
    await db.rawUpdate('''
      UPDATE customer_order
      SET quantity = quantity - 1
      WHERE id = ?
    ''', [orderId]);

    final result = await db.query(
      'customer_order',
      where: 'id = ?',
      whereArgs: [orderId],
    );
    return OrderModel.fromMap(result.first);
  }

  @override
  Future<void> deleteOrder(String orderId) async {
    Database db = await dbHelper.database;
    await db.delete(
      'customer_order',
      where: 'id = ?',
      whereArgs: [orderId],
    );
  }

  @override
  Future<void> addOrder(int productId, int seatingAreaId, String productName,
      double price) async {
    Database db = await dbHelper.database;

    final existingOrder = await db.query(
      'customer_order',
      where: 'product_id = ? AND seating_area_id = ?',
      whereArgs: [productId, seatingAreaId],
    );
    if (existingOrder.isNotEmpty) {
      // Если запись найдена, увеличиваем quantity на 1
      final currentQuantity = existingOrder.first['quantity'] as int;
      await db.update(
        'customer_order',
        {'quantity': currentQuantity + 1},
        where: 'product_id = ? AND seating_area_id = ?',
        whereArgs: [productId, seatingAreaId],
      );
    } else {
      // Если запись не найдена, вставляем новую с UUID
      final String id = const Uuid().v4();
      await db.insert(
        'customer_order',
        {
          'id': id,
          'product_id': productId,
          'seating_area_id': seatingAreaId,
          'product_name': productName,
          'product_price': price,
          'quantity': 1,
        },
      );
    }
  }
} 