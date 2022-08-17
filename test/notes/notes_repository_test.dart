import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_feather_book_mobile/models/notes.dart';
import 'package:my_feather_book_mobile/services/notes_services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  late NotesService notesService;

  setUp(() {
    notesService = NotesService();
  });
  test("Reccupère la liste des notes vides !", () {
    List<Notes> notes = notesService.notes;
    expect(notes.length, 0);
    expect(notes, []);
  });

  test("Recupère la des notes créées au départ !", () async {
    List<Notes> notes = await notesService.getNotes();
    expect(notes.length != 0, true);
  });
}
