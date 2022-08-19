// import 'dart:async';
// import 'dart:io';
//
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
//
// class DatabaseHelper {
//   static DatabaseHelper _instance = DatabaseHelper._internal();
//   late Database _db;
//
//   static final _databaseName = "pmayg.db";
//   static final _databaseVersion = 1;
//   static final REGISTRATION='registration';
//   static final ID = 'id';
//   static final USERID = 'user_id';
//   static final PASSWORD = 'password';
//   static final IMEI_NO = 'imei_no';
//   static final DEVICE_NO = 'device_no';
//   static final MOBILE_NO = 'mobile_no';
//   static final DATE = 'date_of_reg';
//   static final API = 'api_key';
//   static final UTYPE='user_type';
//
//   factory DatabaseHelper() {
//     if (_instance == null) {
//       _instance = DatabaseHelper._internal();
//     }
//     return _instance;
//   }
//
//   DatabaseHelper._internal();
//
//   Future<Database> get db async {
//     if (_db != null) {
//       return _db;
//     }
//
//     _db = await initDb();
//     return _db;
//   }
//
//   initDb() async{
//     Directory documentDirectory = await getApplicationDocumentsDirectory();
//     String path = documentDirectory.path + "todo_db.db";
//
//     var db = await openDatabase(path, version:  1, onCreate: _onCreate);
//     return db;
//   }
//
//   FutureOr<void> _onCreate(Database db, int version) async{
//     await db.execute(
//       "CREATE TABLE $REGISTRATION ($ID INTEGER PRIMARY KEY, $USERID TEXT NOT NULL, $PASSWORD TEXT NOT NULL,$IMEI_NO TEXT NOT NULL,$DEVICE_NO TEXT NOT NULL,$MOBILE_NO INTEGER NOT NULL)"
//     );
//   }
//
//
//   // Future<int> saveItem(model item) async{
//   //     var dbClient = await db;
//   //     int res = await dbClient.insert('$REGISTRATION', item.toMap());
//   //     return res;
//   // }
//   //
//   // Future<model> getItem(int id) async {
//   //     var dbClient = await db;
//   //     var result = await dbClient.rawQuery('SELECT * FROM $REGISTRATION');
//   //     return model.fromMap(result.first);
//   // }
//
//   // Future<List> getAllItems() async {
//   //     var dbClient = await db;
//   //     var result = await dbClient.rawQuery('SELECT * FROM $tableItem ORDER BY $columnId DESC');
//   //     return result.toList();
//   // }
//   //
//   // Future<int> getItemsCount() async {
//   //     var dbClient = await db;
//   //     return Sqflite.firstIntValue(
//   //       await dbClient.rawQuery('SELECT COUNT(*) FROM $tableItem')
//   //     );
//   // }
//   //
//   // Future<int> deleteItem(int id) async{
//   //     var dbClient = await db;
//   //     return await dbClient.delete(tableItem, where: "$columnId = ?", whereArgs: [id]);
//   // }
//   //
//   // Future<int> updateItem(TodoItem item) async {
//   //     var dbClient = await db;
//   //     return await dbClient.update(tableItem, item.toMap(), where: '$columnId = ?', whereArgs: [item.id]);
//   // }
//
//   Future close() async {
//     var dbClient = await db;
//     return dbClient.close();
//   }
//
//
// }
