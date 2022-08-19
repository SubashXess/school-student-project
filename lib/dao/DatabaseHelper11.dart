import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper11 {

  static final _databaseName = "Boowkly.db";
  static final _databaseVersion = 1;

  static final cart_table = 'cart_table';

  static final Id = 'id';
  static final issueId = 'issue_id';
  static final issues = 'issues';
  static final subcat = 'subcat';
  static final issuesQty = 'qty';
  static final price = 'price';
  static final image='image';

  // make this a singleton class
  DatabaseHelper11._privateConstructor();
  static final DatabaseHelper11 instance = DatabaseHelper11._privateConstructor();

  // only have a single app-wide reference to the database
  late Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $cart_table (
            $Id INTEGER PRIMARY KEY,
            $image TEXT NOT NULL,
            $issueId INTEGER NOT NULL,
            $issues TEXT NOT NULL,
            $subcat TEXT NOT NULL,
            $issuesQty INTEGER NOT NULL,
            $price INTEGER NOT NULL
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(cart_table, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(cart_table);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int?> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $cart_table'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[issueId];
    return await db.update(cart_table, row, where: '$issueId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(cart_table, where: '$issueId = ?', whereArgs: [id]);
  }
  Future<int> deleteCartData(int id) async {
    Database db = await instance.database;
    return await db.delete(cart_table,where: '$Id = ?', whereArgs: [id]);
  }
  Future<int> deleteTable() async {
    Database db = await instance.database;
    return await db.delete(cart_table );
  }
  Future getTotal() async {
    var dbClient = await instance.database;
    var result = await dbClient.rawQuery("SELECT SUM(price) FROM $cart_table");
    Object value = result[0]["SUM(price)"]??0; // value = 220
    print('SUM :'+value.toString());
    print('SUM11 :'+result.toString());
    return value.toString();
  }
}