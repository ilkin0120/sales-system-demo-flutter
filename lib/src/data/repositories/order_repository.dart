import 'package:sqflite/sqflite.dart';
import 'package:test_task/src/data/models/customer_order.dart';

import '../db_helper.dart';

abstract class IOrderRepository {
  Future<List<CustomerOrder>> getOrdersBySeatingId(int seatId);

  Future<CustomerOrder> incrementQuantity(int orderId);

  Future<CustomerOrder> decrementQuantity(int orderId);

  Future<void> deleteOrder(int orderId);

  Future<void> addOrder(
      int productId, int seatingAreaId, String productName, double price);
}

class OrderRepository implements IOrderRepository {
  @override
  Future<List<CustomerOrder>> getOrdersBySeatingId(int seatId) async {
    Database db = await DbHelper().database;
    var result = await db.query('customer_order',
        where: 'seating_area_id = ?', whereArgs: [seatId]);
    return result.map((json) => CustomerOrder.fromMap(json)).toList();
  }

  @override
  Future<CustomerOrder> incrementQuantity(int orderId) async {
    Database db = await DbHelper().database;
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
    return CustomerOrder.fromMap(result.first);
  }

  @override
  Future<CustomerOrder> decrementQuantity(int orderId) async {
    Database db = await DbHelper().database;
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
    return CustomerOrder.fromMap(result.first);
  }

  @override
  Future<void> deleteOrder(int orderId) async {
    Database db = await DbHelper().database;
    await db.delete(
      'customer_order',
      where: 'id = ?',
      whereArgs: [orderId],
    );
  }

  @override
  Future<void> addOrder(int productId, int seatingAreaId, String productName,
      double price) async {
    Database db = await DbHelper().database;

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
      // Если запись не найдена, вставляем новую
      await db.insert(
        'customer_order',
        {
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
