import 'package:my_feather_book_mobile/models/dto/notes.dart';
import 'package:my_feather_book_mobile/view/view.dart';

abstract class NotesView implements View {
  void loadNotesOnView(List<Notes> notes);

  void move();
}
