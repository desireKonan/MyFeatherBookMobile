import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyFeatherBookDatabase {
  static final MyFeatherBookDatabase instance = MyFeatherBookDatabase._init();

  static Database? _database;

  MyFeatherBookDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('my_feather_book.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final databasePath = await getDatabasesPath();
    final String path = join(databasePath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    Batch batch = db.batch();

    batch.execute('''
      CREATE TABLE IF NOT EXISTS Notes(
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        createDate TEXT,
        updateDate TEXT
      );
    ''');

    batch.execute('''
      CREATE TABLE IF NOT EXISTS Task(
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        is_finished INTEGER NOT NULL,
        createDate TEXT,
        updateDate TEXT
      );
    ''');

    batch.execute('''
      CREATE TABLE IF NOT EXISTS Goals(
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        is_accomplished INTEGER NOT NULL,
        startDate TEXT,
        endDate TEXT,
        executionTime INTEGER,
        createDate TEXT,
        updateDate TEXT
      );
    ''');

    batch.execute('''
      CREATE TABLE IF NOT EXISTS SubGoals(
        id INTEGER PRIMARY KEY,
        content TEXT NOT NULL,
        is_accomplished INTEGER,
        goal_id INTEGER,
        createDate TEXT,
        updateDate TEXT
      );
    ''');

    batch.execute('''
      CREATE TABLE IF NOT EXISTS DailyNote(
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        createDate TEXT,
        updateDate TEXT
      );
    ''');

    List<dynamic> res = await batch.commit(exclusive: true, noResult: true);

    res.forEach((element) => print(element));
  }

  Future<void> close() async {
    final database = await instance.database;
    database.close();
  }
}
