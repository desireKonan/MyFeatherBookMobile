import 'package:my_feather_book_mobile/models/dto/diary.dart';
import 'package:my_feather_book_mobile/models/repository/diary_repository.dart';
import 'package:my_feather_book_mobile/models/repository/repository.dart';
import 'package:my_feather_book_mobile/presenter/presenter.dart';
import 'package:my_feather_book_mobile/view/feather_room/feather_room_view.dart';

class ListFeatherRoomPresenter implements Presenter {
  late Repository<Diary, int> _repository;
  late FeatherRoomView _view;

  ListFeatherRoomPresenter(FeatherRoomView view)
      : _repository = DiaryRepository(),
        this._view = view;

  Future<List<Diary>> getDailyNotes() async {
    List<Diary> notes = await _repository.getAll();
    return notes;
  }

  void closeDB() {
    _repository.close();
  }

  @override
  void move() {
    _view.move();
  }
}
