import 'package:my_feather_book_mobile/models/dto/diary.dart';
import 'package:my_feather_book_mobile/models/repository/diary_repository.dart';
import 'package:my_feather_book_mobile/models/repository/repository.dart';
import 'package:my_feather_book_mobile/view/feather_room/create_feather_room_view.dart';

class DeleteFeatherRoomPresenter {
  late Repository<Diary, int> _repository;
  late CreateUpdateFeatherRoomView _view;

  final _message = "Notes du journal de bord supprimé avec succès !";

  DeleteFeatherRoomPresenter(CreateUpdateFeatherRoomView view)
      : _repository = DiaryRepository(),
        this._view = view;

  Diary get notes => _view.getDailyNotes();

  Future<Diary> getNotes(int id) async {
    Diary notes = await _repository.getData(id);
    return notes;
  }

  void deleteNote(int id) async {
    _repository.deleteData(id);
    _view.move();
    _view.showSnackBar(_message);
  }
}
