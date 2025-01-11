import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  static Database? _database;

  factory DbHelper() => _instance;

  DbHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'sales.db');
    await deleteDatabase(path); // Удаляем файл базы данных
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'sales.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Создание таблицы категорий
        await db.execute('''
          CREATE TABLE category (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL
          )
        ''');
        // Создание таблицы товаров
        await db.execute('''
          CREATE TABLE product (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            category_id INTEGER NOT NULL,
            name TEXT NOT NULL,
            imageUrl TEXT NOT NULL,
            price REAL NOT NULL,
            stock INTEGER NOT NULL,
            FOREIGN KEY (category_id) REFERENCES category (id)
          )
        ''');
        await db.execute('''
          CREATE TABLE zone (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE seating_area (
             id INTEGER PRIMARY KEY AUTOINCREMENT,
             zone_id INTEGER NOT NULL,
             name TEXT NOT NULL,
             FOREIGN KEY (zone_id) REFERENCES zone (id)
          )
        ''');
        await db.execute('''
          CREATE TABLE customer_order (
             id INTEGER PRIMARY KEY AUTOINCREMENT,
             seating_area_id INTEGER NOT NULL,
             product_id INTEGER NOT NULL,
             product_name TEXT NOT NULL,
             product_price REAL NOT NULL,
             quantity INTEGER NOT NULL,
             FOREIGN KEY (seating_area_id) REFERENCES seating_area (id)
             FOREIGN KEY (product_id) REFERENCES product (id)
          )
        ''');
        // Инициализация данными
        await _populateDatabase(db);
      },
    );
  }

  Future<void> _populateDatabase(Database db) async {
    await _addCategories(db);
    await _addZones(db);
    await _addSeatingAreas(db);
    await _addProducts(db);
  }

  Future<void> _addCategories(Database db) async {
    // Вставляем категории
    await db.insert('category', {'name': 'Блюда 1'});
    await db.insert('category', {'name': 'Блюда 2'});
    await db.insert('category', {'name': 'Напитки'});
  }

  Future<void> _addZones(Database db) async {
    // Вставляем зоны для размещения
    await db.insert('zone', {'name': 'Основной зал'});
    await db.insert('zone', {'name': 'Веранда'});
  }

  Future<void> _addSeatingAreas(Database db) async {
    // Вставляем столы
    await db.insert('seating_area', {
      'zone_id': 1,
      'name': 'Столик 1',
    });
    await db.insert('seating_area', {
      'zone_id': 1,
      'name': 'Столик 2',
    });
    await db.insert('seating_area', {
      'zone_id': 2,
      'name': 'VIP 1',
    });

    await db.insert('seating_area', {
      'zone_id': 2,
      'name': 'VIP 2',
    });
  }

  Future<void> _addProducts(Database db) async {
    // Вставляем продукты
    await db.insert('product', {
      'category_id': 1,
      'name': "Суп «Харчо»",
      'price': 350.0,
      'stock': 13,
      'imageUrl':
          'https://e1.edimdoma.ru/data/posts/0002/2542/22542-ed4_wide.jpg?1631192811',
    });
    await db.insert('product', {
      'category_id': 1,
      'name': 'Куриный суп с чесночными галушками',
      'price': 300.0,
      'stock': 5,
      'imageUrl':
          'https://e1.edimdoma.ru/data/posts/0002/2542/22542-ed4_wide.jpg?1631192811',
    });
    await db.insert('product', {
      'category_id': 2,
      'name': 'Швейцарский решти',
      'price': 800.0,
      'stock': 2,
      'imageUrl':
          'https://e1.edimdoma.ru/data/posts/0002/2542/22542-ed4_wide.jpg?1631192811',
    });
    await db.insert('product', {
      'category_id': 2,
      'name': 'Жаркое по-деревенски',
      'price': 800.0,
      'stock': 12,
      'imageUrl':
          'https://e1.edimdoma.ru/data/posts/0002/2542/22542-ed4_wide.jpg?1631192811',
    });
    await db.insert('product', {
      'category_id': 2,
      'name': 'Макароны с мясом в томатном соусе, на сковороде',
      'price': 400.0,
      'stock': 2,
      'imageUrl':
          'https://e1.edimdoma.ru/data/posts/0002/2542/22542-ed4_wide.jpg?1631192811',
    });
    await db.insert('product', {
      'category_id': 3,
      'name': 'Coca-Cola Classic 2л Пластик',
      'price': 190.0,
      'stock': 23,
      'imageUrl':
          'https://cdn-img.perekrestok.ru/i/800x800-fit/xdelivery/files/40/bf/fd891f665e5408be282971809895.jpg',
    });
    await db.insert('product', {
      'category_id': 3,
      'name': 'Coca-Cola Classic 0.33 ЖБ',
      'price': 220.0,
      'stock': 90,
      'imageUrl':
          'https://enzym.ru/wa-data/public/shop/products/62/76/47662/images/49564/49564.970.jpg',
    });
  }
}
