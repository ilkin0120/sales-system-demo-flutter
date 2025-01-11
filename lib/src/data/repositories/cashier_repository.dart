import 'package:sqflite/sqflite.dart';

import '../db_helper.dart';
import '../models/bill.dart';

abstract class ICashierRepository {
  Future<List<Bill>> getBills();
}

class CashierRepository implements ICashierRepository {
  @override
  Future<List<Bill>> getBills() async {
    Database db = await DbHelper().database;
    List<Bill> result = [];
    final queryResult = await db.rawQuery('''
    SELECT 
        seating_area.id AS seat_id,
        seating_area.name AS seat_name,
        SUM(customer_order.product_price * customer_order.quantity) AS total_bill
    FROM seating_area
    LEFT JOIN customer_order ON seating_area.id = customer_order.seating_area_id
    GROUP BY seating_area.id, seating_area.name
  ''');
    for (final bill in queryResult) {
      result.add(Bill.fromMap(bill));
    }
    return result;
  }
}
