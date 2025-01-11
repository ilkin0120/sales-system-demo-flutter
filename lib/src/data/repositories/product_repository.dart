// Получить все группы
import 'package:sqflite/sqflite.dart';
import 'package:test_task/src/data/db_helper.dart';

import '../models/product.dart';
import '../models/product_group.dart';

abstract class IProductRepository {
  Future<List<ProductGroup>> fetchGroups();

  Future<List<Product>> fetchProductsByGroup(int groupId);
}

class ProductRepository implements IProductRepository {
  @override
  Future<List<ProductGroup>> fetchGroups() async {
    Database db = await DbHelper().database;
    var result = await db.query('category');
    return result.map((json) => ProductGroup.fromMap(json)).toList();
  }

  @override
  Future<List<Product>> fetchProductsByGroup(int groupId) async {
    Database db = await DbHelper().database;
    var result = await db
        .query('product', where: 'category_id = ?', whereArgs: [groupId]);
    return result.map((json) => Product.fromMap(json)).toList();
  }
}
