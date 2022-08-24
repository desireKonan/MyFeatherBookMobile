import 'package:flutter/material.dart';
import 'package:my_feather_book_mobile/components/card_notes.dart';
import 'package:my_feather_book_mobile/components/my_feather_transition_page.dart';
import 'package:my_feather_book_mobile/helpers/constants.dart';
import 'package:my_feather_book_mobile/helpers/ui_helpers.dart';
import 'package:my_feather_book_mobile/models/dto/notes.dart';
import 'package:my_feather_book_mobile/presenter/list_notes_presenter.dart';
import 'package:my_feather_book_mobile/screen/notes/note_details_page.dart';
import 'package:my_feather_book_mobile/view/notes_view.dart';
import 'package:staggered_grid_view_flutter/rendering/sliver_staggered_grid.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> implements NotesView {
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
    });
  }

  @override
  void move() {
    Navigator.of(context).pushNamed(route);
  }

  @override
  void dispose() {
    _presenter.closeDB();
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
      appBar: AppBar(
        // Here we take the value from the TemplatePage object that was created by
        // the App.build method, and use it to set our appbar title.
        //title: const Text(APP_NAME),
        backgroundColor: Colors.teal,
      ),
      drawer: buildDrawer(context),
      body: RefreshIndicator(
        onRefresh: refreshNotes,
        child: FutureBuilder(
            initialData: _notes,
            future: _presenter.getNotes(),
            builder: (buildContext, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blueAccent,
                  ),
                );
              } else {
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
                      staggeredTileBuilder: (index) =>
                          const StaggeredTile.fit(1),
                    ));
              }
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
