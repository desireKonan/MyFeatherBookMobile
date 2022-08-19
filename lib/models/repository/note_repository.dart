import 'dart:ffi';

import 'package:my_feather_book_mobile/config/database.dart';
import 'package:my_feather_book_mobile/models/dto/notes.dart';
import 'package:my_feather_book_mobile/models/repository/repository.dart';
import 'package:sqflite/sqflite.dart';

class NoteRepository implements Repository<Notes, int> {
  late final MyFeatherBookDatabase _myFeatherBookDatabase;

  NoteRepository() : _myFeatherBookDatabase = MyFeatherBookDatabase.instance;

  @override
  Future<List<Notes>> getAll() async {
    Database database = await _myFeatherBookDatabase.database;
    List<Map<String, dynamic>> notes = await database.query("Notes");
    return notes.map((note) => Notes.fromJson(note)).toList();
  }

  @override
  Future<Notes> getData(int id) async {
    Database database = await _myFeatherBookDatabase.database;
    List<Map<String, dynamic>> notes = await database.query(
      "Notes",
      distinct: true,
      columns: ['id', 'title', 'content', 'createDate', 'updateDate'],
      where: 'id = ?',
      whereArgs: [id],
    );

    var newNote = Notes.init();

    if (notes.isNotEmpty) {
      newNote = Notes.fromJson(notes.first);
    } else {
      throw Exception("Cette note ${newNote.id} n'existes pas !");
    }

    return newNote;
  }

  @override
  Future<Notes> insert(Notes data) async {
    Database database = await _myFeatherBookDatabase.database;
    int isInserted = await database.insert(
      "Notes",
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    database.close();

    if (isInserted == 0) {
      throw Exception("Erreur lors de l'ajout de la note !");
    }

    return Notes(
        id: data.id,
        title: data.title,
        content: data.content,
        createdDate: data.createdDate,
        updatedDate: data.updatedDate);
  }

  @override
  Future<Notes> update(int id, Notes data) async {
    Database database = await _myFeatherBookDatabase.database;
    int isUpdated = await database.update(
      "Notes",
      data.toMap(),
      where: 'id = ?',
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    if (isUpdated == 0) {
      throw Exception("Erreur dans la modification de la note !");
    }

    return Notes(
        id: data.id,
        title: data.title,
        content: data.content,
        createdDate: data.createdDate,
        updatedDate: data.updatedDate);
  }

  @override
  void delete(int id) async {
    Database database = await _myFeatherBookDatabase.database;
    int isDelete = await database.delete(
      "Notes",
      where: 'id = ?',
      whereArgs: [id],
    );

    if (isDelete == 0) {
      throw Exception(
          "Erreur de la suppression de la note ! Vous essayer de supprimer une note qui n'existe pas !");
    }
  }

  @override
  void close() async {
    Database database = await _myFeatherBookDatabase.database;
    database.close();
  }
}
