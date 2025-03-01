import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseService {
  static const String _databaseName = 'restaurant-app.db';
  static const String _tableName = 'favorite_restaurants';
  static const int _version = 1;

  Future<void> createTables(Database database) async {
    await database.execute(
      '''
      CREATE TABLE $_tableName(
        id TEXT PRIMARY KEY,
        name TEXT,
        description TEXT,
        picture_id TEXT,
        city TEXT,
        rating REAL
      )
      ''',
    );
  }

  Future<Database> _initializeDb() async {
    return openDatabase(
      _databaseName,
      version: _version,
      onCreate: (db, version) async => await createTables(db),
    );
  }

  Future<int> insertItem(Restaurant restaurant) async {
    final db = await _initializeDb();

    final data = restaurant.toDbMap();
    final id = await db.insert(
      _tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<List<Restaurant>> getAllItems() async {
    final db = await _initializeDb();
    final results = await db.query(_tableName);

    return results.map((result) => Restaurant.fromDbMap(result)).toList();
  }

  Future<Restaurant> getItemById(String id) async {
    final db = await _initializeDb();
    final results = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    return results.map((result) => Restaurant.fromDbMap(result)).first;
  }

  Future<int> removeItem(String id) async {
    final db = await _initializeDb();

    final result = await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return result;
  }
}
