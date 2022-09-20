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
    Notes notes = _notes.elementAt(id);
    notes.content = note.content;
    notes.title = note.title;
    notes.updatedDate = DateTime.now();
    notifyListeners();
  }

  void clear() {
    _notes.clear();

    notifyListeners();
  }
}
