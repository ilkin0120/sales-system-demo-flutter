import 'package:sqflite/sqflite.dart';
import '../../models/product_group_model.dart';
import '../../models/product_model.dart';
import 'db_helper.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductGroupModel>> getProductGroups();
  Future<List<ProductModel>> getProductsByGroup(int groupId);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final DbHelper dbHelper;

  ProductLocalDataSourceImpl({required this.dbHelper});

  @override
  Future<List<ProductGroupModel>> getProductGroups() async {
    Database db = await dbHelper.database;
    var result = await db.query('category');
    return result.map((json) => ProductGroupModel.fromMap(json)).toList();
  }

  @override
  Future<List<ProductModel>> getProductsByGroup(int groupId) async {
    Database db = await dbHelper.database;
    var result = await db
        .query('product', where: 'category_id = ?', whereArgs: [groupId]);
    return result.map((json) => ProductModel.fromMap(json)).toList();
  }
} 