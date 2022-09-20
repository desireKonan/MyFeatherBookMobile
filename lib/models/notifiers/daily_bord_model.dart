import 'package:flutter/foundation.dart';
import 'package:my_feather_book_mobile/models/dto/diary.dart';

class DailyBoardModel with ChangeNotifier {
  List<Diary> _diaryPages = [];

  List<Diary> get notes => _diaryPages;

  set newNotes(List<Diary> notes) {
    _diaryPages = notes;

    notifyListeners();
  }

  void add(Diary note) {
    _diaryPages.add(note);

    notifyListeners();
  }

  void remove(Diary note) {
    _diaryPages.remove(note);

    notifyListeners();
  }

  void update(int id, Diary note) {
    Diary diary = _diaryPages.elementAt(id);
    diary.content = note.content;
    diary.title = note.title;
    diary.updatedDate = DateTime.now();
    notifyListeners();
  }
}
