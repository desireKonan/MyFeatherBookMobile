import 'package:my_feather_book_mobile/models/dto/notes.dart';
import 'package:my_feather_book_mobile/models/repository/note_repository.dart';
import 'package:my_feather_book_mobile/models/repository/repository.dart';
import 'package:my_feather_book_mobile/presenter/presenter.dart';
import 'package:my_feather_book_mobile/view/notes_view.dart';

class ListNotesPresenter implements Presenter {
  late Repository<Notes, int> _repository;
  late NotesView _view;

  ListNotesPresenter(NotesView view)
      : _repository = NoteRepository(),
        this._view = view;

  List<Notes> get notes => _view.notes;

  Future<List<Notes>> getNotes() async {
    _view.notes = await _repository.getAll();
    return _view.notes;
  }

  void closeDB() {
    _repository.close();
  }

  @override
  void move() {
    _view.move();
  }
}
