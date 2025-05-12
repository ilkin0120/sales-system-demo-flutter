import 'package:sqflite/sqflite.dart';
import '../../models/seating_area_model.dart';
import '../../models/zone_model.dart';
import 'db_helper.dart';

abstract class HomeLocalDataSource {
  Future<List<ZoneModel>> getZones();
  Future<List<SeatingAreaModel>> getSeatingAreasByZone(int zoneId);
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final DbHelper dbHelper;

  HomeLocalDataSourceImpl({required this.dbHelper});

  @override
  Future<List<SeatingAreaModel>> getSeatingAreasByZone(int zoneId) async {
    Database db = await dbHelper.database;
    var result = await db
        .query('seating_area', where: 'zone_id = ?', whereArgs: [zoneId]);
    return result.map((json) => SeatingAreaModel.fromMap(json)).toList();
  }

  @override
  Future<List<ZoneModel>> getZones() async {
    Database db = await dbHelper.database;
    var result = await db.query('zone');
    return result.map((json) => ZoneModel.fromMap(json)).toList();
  }
} 