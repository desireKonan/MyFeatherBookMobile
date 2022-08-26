import 'package:my_feather_book_mobile/models/dto/notes.dart';
import 'package:my_feather_book_mobile/view/view.dart';

abstract class FeatherRoomView implements View {
  List<Notes> getNotes();

  void setNotes(List<Notes> notes);

  void move();
}
