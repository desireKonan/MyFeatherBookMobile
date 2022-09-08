import 'package:flutter/cupertino.dart';
import 'package:my_feather_book_mobile/models/dto/notes.dart';

class NoteModel with ChangeNotifier {
  List<Notes> _notes = [];

  List<Notes> get notes => _notes;

  set newNotes(List<Notes> notes) {
    _notes = notes;

    notifyListeners();
  }

  void add(Notes note) {
    _notes.add(note);

    notifyListeners();
  }

  void remove(Notes note) {
    _notes.remove(note);

    notifyListeners();
  }

  void update(int id, Notes note) {
    if (_notes.contains(note)) {
      _notes.elementAt(id)
        ..content = note.content
        ..title = note.title
        ..updatedDate = DateTime.now();
      notifyListeners();
    } else {
      throw Exception("L'élement à supprimer n'existes pas !");
    }
  }

  void clear() {
    _notes.clear();

    notifyListeners();
  }
}
