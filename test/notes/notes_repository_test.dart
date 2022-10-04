import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Database db;

  setUpAll(() async {
    // Initialize ffi implementation
    sqfliteFfiInit();
    // Set global factory, do not use isolate here
    databaseFactory = databaseFactoryFfiNoIsolate;
    db = await openDatabase(inMemoryDatabasePath, version: 1,
        onCreate: (db, version) async {
      await db
          .execute('CREATE TABLE Notes (id INTEGER PRIMARY KEY, text TEXT)');
    });
  });

  group("Notes CRUD Test", () {
    test('Get all notes from Database', () async {
      // Insert some data
      var result = await db.query('Notes');

      // Check content
      expect(result, []);
    });

    test('Get a specific note from Database', () async {
      var note = {'id': 1, 'text': 'Première Note !'};

      await db.insert('Notes', note);

      var result = await db.query("Notes",
          distinct: true, where: 'text = ?', whereArgs: [note['text']]);

      expect(note, result[0]);
    });

    test('Insert a note in Database', () async {
      var note = {'id': 2, 'text': 'Première Note !'};

      int id = await db.insert('Notes', note);

      expect(id, note['id']);
    });

    test('Update a specific note from Database', () async {
      var note = {'id': 2, 'text': 'Première Note !'};

      var newNote = {'id': 2, 'text': 'Seconde note !'};

      int insertId = await db.insert('Notes', note);

      int id = await db.update(
        'Notes',
        newNote,
        where: 'id = ?',
        whereArgs: [note['id']],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      var result = await db.query("Notes",
          distinct: true, where: 'text = ?', whereArgs: [newNote['text']]);

      expect(newNote, result[0]);
    });

    test('Delete a specific note from Database', () async {
      var note = {'id': 2, 'text': 'Première Note !'};

      var newNote = [];

      int insertId = await db.insert('Notes', note);

      int deletedId = await db
          .delete("Notes", where: 'text = ?', whereArgs: [note['text']]);

      var result = await db.query("Notes",
          distinct: true, where: 'text = ?', whereArgs: [note['text']]);

      expect(newNote, result);
    });

    setUp(() async {
      await db.close();
    });
  });
}
