import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyFeatherBookDatabase {
  static final MyFeatherBookDatabase instance = MyFeatherBookDatabase._init();

  static Database? _database;

  MyFeatherBookDatabase._init();

  Future<Database> get database async {
    if (database != null) return _database!;

    _database = await _initDB('myfeatherbook.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final databasePath = await getDatabasesPath();
    final String path = join(databasePath, filePath);

    print(path);

    return await openDatabase(
      path,
      version: 1,
      onOpen: _openDB,
    );
  }

  Future<void> _openDB(Database db) async {
    print("La base de données ${db.path} est ${db.isOpen}");
  }

  Future<void> close() async {
    final database = await instance.database;
    database.close();
  }
}
