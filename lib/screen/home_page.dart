import 'package:flutter/material.dart';
import 'package:my_feather_book_mobile/components/card_notes.dart';
import 'package:my_feather_book_mobile/helpers/constants.dart';
import 'package:my_feather_book_mobile/helpers/ui_helpers.dart';
import 'package:my_feather_book_mobile/models/dto/notes.dart';
import 'package:my_feather_book_mobile/models/repository/note_repository.dart';
import 'package:my_feather_book_mobile/presenter/list_notes_presenter.dart';
import 'package:my_feather_book_mobile/screen/notes/notes_detail_page.dart';
import 'package:my_feather_book_mobile/view/notes_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /*late List<Notes> _notes = List<Notes>.empty();

  late NoteRepository _noteRepository;

  void _passToScreen() {
    Navigator.of(context).pushNamed('/createNote');
  }*/

  late NotesView _notesView;

  late ListNotesPresenter _presenter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notesView = NotesView(context: context);
    _presenter = ListNotesPresenter(_notesView);
  }

  @override
  void dispose() {
    _presenter.closeDB();
    super.dispose();
  }

  void _moveToCardNoteDetails(int index) {
    debugPrint("cliqué !");
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NoteDetailPage(
          noteId: index,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the TemplatePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text(APP_NAME),
      ),
      drawer: buildDrawer(context),
      body: FutureBuilder(
          initialData: List<Notes>.empty,
          future: _presenter.getNotes(),
          builder: (buildContext, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator(
                color: Colors.blueAccent,
              );
            } else {
              //Grid view concernant les informations
              return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 15,
                ),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5.5,
                  ),
                  children: List.generate(
                    _presenter.notes.length,
                    (index) => Builder(
                      builder: (context) => GestureDetector(
                        onTap: () =>
                            _moveToCardNoteDetails(_presenter.notes[index].id),
                        child: NoteCard(
                          note: _presenter.notes[index],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _presenter.move,
        tooltip: 'Créée une nouvelle note',
        child: const Icon(Icons.add),
      ),
    );
  }
}
