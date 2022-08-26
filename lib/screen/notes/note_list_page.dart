import 'package:flutter/material.dart';
import 'package:my_feather_book_mobile/components/card_notes.dart';
import 'package:my_feather_book_mobile/components/my_feather_transition_page.dart';
import 'package:my_feather_book_mobile/models/dto/notes.dart';
import 'package:my_feather_book_mobile/presenter/notes/list_notes_presenter.dart';
import 'package:my_feather_book_mobile/screen/notes/note_details_page.dart';
import 'package:my_feather_book_mobile/view/notes/notes_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({Key? key}) : super(key: key);

  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> implements NotesView {
  late List<Notes> _notes;

  String route = "/createNote";

  late ListNotesPresenter _presenter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notes = List<Notes>.empty();
    _presenter = ListNotesPresenter(this);

    refreshNotes();
  }

  @override
  List<Notes> getNotes() => _notes;

  @override
  setNotes(List<Notes> notes) {
    _notes = notes;
  }

  Future refreshNotes() async {
    List<Notes> notes = await _presenter.getNotes();
    setState(() {
      _notes = notes;
      print(_notes.toList().toString());
    });
  }

  @override
  void move() {
    Navigator.of(context).pushNamed(route);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _moveToCardNoteDetails(int index) {
    Navigator.of(context).push(
      MyFeatherTransitionPage(
        child: NoteDetailsPage(
          noteId: index,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refreshNotes,
        child: FutureBuilder(
            initialData: _notes,
            future: _presenter.getNotes(),
            builder: (buildContext, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}',
                        style: const TextStyle(backgroundColor: Colors.teal)),
                  );
                }
                //Grid view concernant les informations
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: StaggeredGridView.countBuilder(
                    shrinkWrap: true,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    itemCount: _notes.length,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () => _moveToCardNoteDetails(_notes[index].id),
                        child: NoteCard(
                          note: _notes[index],
                        ),
                      );
                    }),
                    staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.teal,
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: _presenter.move,
        tooltip: 'Créer une nouvelle note',
        child: const Icon(Icons.add),
      ),
    );
  }
}
