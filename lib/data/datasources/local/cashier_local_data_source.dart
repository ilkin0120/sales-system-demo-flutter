import 'package:sqflite/sqflite.dart';
import '../../models/bill_model.dart';
import 'db_helper.dart';

abstract class CashierLocalDataSource {
  Future<List<BillModel>> getBills();
}

class CashierLocalDataSourceImpl implements CashierLocalDataSource {
  final DbHelper dbHelper;

  CashierLocalDataSourceImpl({required this.dbHelper});

  @override
  Future<List<BillModel>> getBills() async {
    Database db = await dbHelper.database;
    List<BillModel> result = [];
    
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
      result.add(BillModel.fromMap(bill));
    }
    
    return result;
  }
} 