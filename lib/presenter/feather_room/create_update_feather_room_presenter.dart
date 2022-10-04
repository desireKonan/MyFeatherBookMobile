import 'package:my_feather_book_mobile/models/dto/diary.dart';
import 'package:my_feather_book_mobile/models/repository/diary_repository.dart';
import 'package:my_feather_book_mobile/models/repository/repository.dart';
import 'package:my_feather_book_mobile/view/feather_room/create_feather_room_view.dart';

class CreateUpdateFeatherRoomPresenter {
  late Repository<Diary, int> _repository;
  late CreateUpdateFeatherRoomView _view;

  final _MESSAGE = "Notes du journal de bord ajoutée avec succès !";

  CreateUpdateFeatherRoomPresenter(CreateUpdateFeatherRoomView view)
      : _repository = DiaryRepository(),
        this._view = view;

  Diary get notes => _view.getDailyNotes();

  Future<Diary> getNotes(int id) async {
    Diary notes = await _repository.getData(id);
    return notes;
  }

  void saveNotes() async {
    Diary notes = await _repository.insert(this.notes);
    _view.move();
    _view.showSnackBar(_MESSAGE);
  }

  void updateNotes(int id) async {
    Diary notes = await _repository.update(id, this.notes);
    _view.move();
    _view.showSnackBar(_MESSAGE);
  }
}
