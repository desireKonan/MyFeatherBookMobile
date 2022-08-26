import 'dart:ffi';

import 'package:my_feather_book_mobile/config/database.dart';
import 'package:my_feather_book_mobile/models/dto/diary.dart';
import 'package:my_feather_book_mobile/models/repository/repository.dart';
import 'package:sqflite/sqflite.dart';

class DiaryRepository implements Repository<Diary, int> {
  late final MyFeatherBookDatabase _myFeatherBookDatabase;

  DiaryRepository() : _myFeatherBookDatabase = MyFeatherBookDatabase.instance;

  @override
  Future<List<Diary>> getAll() async {
    Database database = await _myFeatherBookDatabase.database;
    List<Map<String, dynamic>> notes = await database.query("Diary");
    return notes.map((note) => Diary.fromJson(note)).toList();
  }

  @override
  Future<Diary> getData(int id) async {
    Database database = await _myFeatherBookDatabase.database;
    List<Map<String, dynamic>> notes = await database.query(
      "Diary",
      distinct: true,
      columns: ['id', 'title', 'content', 'createDate', 'updateDate'],
      where: 'id = ?',
      whereArgs: [id],
    );

    var newNote = Diary.init();

    if (notes.isNotEmpty) {
      newNote = Diary.fromJson(notes.first);
    } else {
      throw Exception(
          "Cette note du journal de bord ${newNote.id} n'existes pas !");
    }

    return newNote;
  }

  @override
  Future<Diary> insert(Diary data) async {
    Database database = await _myFeatherBookDatabase.database;
    int isInserted = await database.insert(
      "Diary",
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    database.close();

    if (isInserted == 0) {
      throw Exception("Erreur lors de l'ajout de la note du journal de bord !");
    }

    return Diary(
        id: data.id,
        title: data.title,
        content: data.content,
        createdDate: data.createdDate,
        updatedDate: data.updatedDate);
  }

  @override
  Future<Diary> update(int id, Diary data) async {
    Database database = await _myFeatherBookDatabase.database;
    int isUpdated = await database.update(
      "Diary",
      data.toMap(),
      where: 'id = ?',
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    if (isUpdated == 0) {
      throw Exception(
          "Erreur dans la modification de la note du journal de bord !");
    }

    return Diary(
        id: data.id,
        title: data.title,
        content: data.content,
        createdDate: data.createdDate,
        updatedDate: data.updatedDate);
  }

  @override
  void deleteData(int id) async {
    Database database = await _myFeatherBookDatabase.database;
    int isDelete = await database.delete(
      "Diary",
      where: 'id = ?',
      whereArgs: [id],
    );

    if (isDelete == 0) {
      throw Exception(
          "Erreur de la suppression de la note ! Vous essayer de supprimer une note du journal de bord qui n'existe pas !");
    }
  }

  @override
  void close() async {
    Database database = await _myFeatherBookDatabase.database;
    database.close();
  }
}
