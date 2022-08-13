import 'package:my_feather_book_mobile/config/database.dart';
import 'package:my_feather_book_mobile/models/notes.dart';
import 'package:sqflite/sqflite.dart';

class NoteRepository {
  NoteRepository();

  Future<Notes> insert(Notes data) async {
    Database database = await MyFeatherBookDatabase.instance.database;
    int isInserted = await database.insert("Notes", data.toJson());
    return data.copy(
        id: data.id,
        title: data.title,
        content: data.content,
        createdDate: data.createdDate,
        updatedDate: data.updatedDate);
  }
}
