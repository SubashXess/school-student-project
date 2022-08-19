import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/Photo.dart';

class DatabaseHelper22 {
  static final _databaseName = "pmayg.db";
  static final _databaseVersion = 1;
  static final VERIFY_TAB = 'verification';
  static final ID = 'id';
  static final IMAGE = 'image';

  // make this a singleton class
  DatabaseHelper22._privateConstructor();
  static final DatabaseHelper22 instance =
      DatabaseHelper22._privateConstructor();

  // only have a single app-wide reference to the database
  Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  //SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    // await db.execute('''
    //       CREATE TABLE $VERIFY_TAB (
    //         $VERIFY_ID INTEGER PRIMARY KEY,
    //         $REF_ID TEXT NOT NULL,
    //         $IMG TEXT NOT NULL,
    //         $STATUS TEXT NOT NULL,
    //         $KHATA_NO TEXT NOT NULL,
    //         $PLOT_NO TEXT NOT NULL)
    //       ''');
    await db.execute('''
          CREATE TABLE $VERIFY_TAB (
            $ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            $IMAGE TEXT)
          ''');
  }

  // static Future<void> insert(Map<String, Object> data) async {
  //   //final db = await DBHelper.database();
  //   Database db = await instance.database;
  //   db.insert(VERIFY_TAB,data,conflictAlgorithm:
  //   ConflictAlgorithm.replace,
  //   );
  // }
  Future<Photo> save(Photo verify) async {
    Database db = await instance.database;
    verify.id = await db.insert(VERIFY_TAB, verify.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('Loading : ${verify.image}');
    return verify;
  }

  Future<List<Photo>> getPhotos() async {
    Database db = await instance.database;
    List<Map> maps = await db.query(VERIFY_TAB, columns: [ID, IMAGE]);
    List<Photo> verify = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        verify.add(Photo.fromMap(maps[i]));
        print('Image 1 : ${verify[i].image}');
      }
    }
    return verify;
  }

  Future<int> insertVerify(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(VERIFY_TAB, row);
  }

  static Future<int?> updateVerify(int v_id) async {
    final data = {'v_status': '1'};
    Database db = await instance.database;
    await db.update(VERIFY_TAB, data, where: 'id = ?', whereArgs: [v_id]);
    // show the results: print all rows in the db
    //print(await db.query(DatabaseHelper.table));

    //return await db.update(REPORT_TAB,where: '$columnId = ?', whereArgs: [id]);
  }

  // Future<int> update(String ref_id, String image, String status, String lat, String lang) async {
  //   Database db = await instance.database;
  //   return await db.rawUpdate(
  //       'UPDATE verification SET image = img,lat = $lat,lang = $lang,status = $status  WHERE v_id = ${int.parse(ref_id)}');
  // }
  static Future<int> update(String ref_id, String image, String status,
      String lat, String lang) async {
    final db = await instance.database;

    final data = {'image': image, 'status': status, 'lat': lat, 'lang': lang};

    final result = await db
        .update('verification', data, where: "ref_id = ?", whereArgs: [ref_id]);
    return result;
  }

  Future<int> updateStatus(String ref_id, String status) async {
    Database db = await instance.database;
    return await db.rawUpdate(
        'UPDATE farmer_tab SET status = $status WHERE ref_id = $ref_id');
  }

  // static Future<void> deleteFromVerify(String id) async {
  //   final db = await instance.database;
  //   try {
  //     await db.delete("verification", where: "v_id = ?", whereArgs: [id]);
  //   } catch (err) {
  //     debugPrint("Something went wrong when deleting an item: $err");
  //   }
  // }
  // static Future<void> deleteFromVerify(String vid) async {
  //   final db = await instance.database;
  //   try {
  //     await db.delete(VERIFY_TAB);
  //   } catch (err) {
  //     debugPrint("Something went wrong when deleting an item: $err");
  //   }
  // }
  static Future<void> deleteFarmer() async {
    final db = await instance.database;
    try {
      await db.delete(VERIFY_TAB);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  static Future<int> deleteFromVerify(int id) async {
    print('DLT4 ' + id.toString());
    Database db = await instance.database;
    return await db.delete(VERIFY_TAB, where: '$ID = ?', whereArgs: [id]);
  }

  // Future<int> insert2(Map<String, dynamic> row) async {
  //   Database db = await instance.database;
  //   return await db.insert(VERIFY_TAB2, row);
  // }
  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(VERIFY_TAB);
  }

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'pmayg.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE jalanidhi(id INTEGER PRIMARY KEY AUTOINCREMENT, v_id TEXT NOT NULL,ref_id TEXT NOT NULL,image TEXT NOT NULL,status TEXT NOT NULL,khata_no TEXT NOT NULL,plot_no TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }
}
