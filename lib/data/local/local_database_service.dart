import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseService {
  static const String _databaseName = 'restaurant-app.db';
  static const String _favoriteTableName = 'favorite_restaurants';
  static const int _version = 1;

  Future<void> createTables(Database database) async {
    await database.execute(
      '''
      CREATE TABLE $_favoriteTableName(
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

  Future<int> insertFavoriteRestaurant(Restaurant restaurant) async {
    final db = await _initializeDb();

    final restaurantData = restaurant.toDbMap();
    final id = await db.insert(
      _favoriteTableName,
      restaurantData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<List<Restaurant>> getAllFavoriteRestaurants() async {
    final db = await _initializeDb();
    final results = await db.query(_favoriteTableName);

    return results.map((result) => Restaurant.fromDbMap(result)).toList();
  }

  Future<Restaurant> getFavoriteRestaurantById(String id) async {
    final db = await _initializeDb();
    final results = await db.query(
      _favoriteTableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    return results.map((result) => Restaurant.fromDbMap(result)).first;
  }

  Future<int> removeFavoriteRestaurant(String id) async {
    final db = await _initializeDb();

    final deletedRows = await db.delete(
      _favoriteTableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return deletedRows;
  }
}
