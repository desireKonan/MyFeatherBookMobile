import 'package:my_feather_book_mobile/models/dto/diary.dart';
import 'package:my_feather_book_mobile/view/view.dart';

abstract class FeatherRoomView implements View {
  void loadDailyNotesOnView(List<Diary> notes);

  void move();
}
