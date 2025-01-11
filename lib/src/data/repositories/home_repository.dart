import 'package:sqflite/sqflite.dart';
import 'package:test_task/src/data/models/seating_area.dart';
import 'package:test_task/src/data/models/zone.dart';

import '../db_helper.dart';

abstract class IHomeRepository {
  Future<List<ZoneModel>> fetchZones();

  Future<List<SeatingArea>> fetchSeatingAreasByZone(int zoneId);
}

class HomeRepository implements IHomeRepository {
  @override
  Future<List<SeatingArea>> fetchSeatingAreasByZone(int zoneId) async {
    Database db = await DbHelper().database;
    var result = await db
        .query('seating_area', where: 'zone_id = ?', whereArgs: [zoneId]);
    return result.map((json) => SeatingArea.fromMap(json)).toList();
  }

  @override
  Future<List<ZoneModel>> fetchZones() async {
    Database db = await DbHelper().database;
    var result = await db.query('zone');
    return result.map((json) => ZoneModel.fromMap(json)).toList();
  }
}
