import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_feather_book_mobile/models/dto/notes.dart';
import 'package:my_feather_book_mobile/view/notes_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  late NotesView notesView;

  setUp(() {
    //notesView = NotesView(context: BuildContext());
  });
  test("Reccupère la liste des notes vides !", () {
    /*List<Notes> notes = notesView.notes;
    expect(notes.length, 0);
    expect(notes, []);*/
  });

  test("Recupère la des notes créées au départ !", () async {
    /*List<Notes> notes = await notesView.notes;
    expect(notes.length != 0, true);*/
  });
}
