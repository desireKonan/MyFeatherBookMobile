import 'package:flutter_test/flutter_test.dart';
import 'package:my_feather_book_mobile/models/dto/notes.dart';
import 'package:my_feather_book_mobile/models/repository/note_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late NoteRepository _noteRepository;
  late List<Notes> _notes;

  setUp(() {
    _noteRepository = NoteRepository();
    _notes = [];
  });

  test("Reccupérer la liste des notes !", () {
    _noteRepository.getAll().then((notes) => _notes = notes);

    expect(_notes, _notes.length != 0);
  });
}
