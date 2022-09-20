import 'package:flutter/material.dart';
import 'package:my_feather_book_mobile/components/card_notes.dart';
import 'package:my_feather_book_mobile/components/my_feather_transition_page.dart';
import 'package:my_feather_book_mobile/models/dto/notes.dart';
import 'package:my_feather_book_mobile/models/notifiers/note_model.dart';
import 'package:my_feather_book_mobile/presenter/notes/list_notes_presenter.dart';
import 'package:my_feather_book_mobile/screen/notes/note_details_page.dart';
import 'package:my_feather_book_mobile/view/notes/notes_view.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({Key? key}) : super(key: key);

  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> implements NotesView {
  String route = "/createNote";

  late ListNotesPresenter _presenter;

  late NoteModel _noteModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _presenter = ListNotesPresenter(this);
    _presenter.fetchNotes();
  }

  @override
  void loadNotesOnView(List<Notes> notes) {
    _noteModel = Provider.of<NoteModel>(context, listen: false);
    _noteModel.newNotes = notes;
  }

  @override
  void move() {
    Navigator.of(context).pushNamed(route);
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
    return Consumer<NoteModel>(
      builder: (context, value, child) => RefreshIndicator(
        onRefresh: _presenter.fetchNotes,
        child: FutureBuilder(
            initialData: value.notes,
            future: _presenter.getNotes(),
            builder: (buildContext, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${snapshot.error}',
                          style: const TextStyle(
                            textBaseline: TextBaseline.alphabetic,
                            color: Colors.teal,
                            fontSize: 20,
                          )),
                    ),
                  );
                }
                //Grid view concernant les informations
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Notes",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.teal,
                                shadows: [
                                  Shadow(),
                                ]),
                          ),
                          const SizedBox(width: 30),
                          MaterialButton(
                            height: 40,
                            onPressed: _presenter.move,
                            elevation: 2.0,
                            color: Colors.teal,
                            shape: const CircleBorder(),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      StaggeredGridView.countBuilder(
                        shrinkWrap: true,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                        controller: ScrollController(),
                        physics: const ScrollPhysics(),
                        itemCount: value.notes.length,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onTap: () =>
                                _moveToCardNoteDetails(value.notes[index].id),
                            child: NoteCard(
                              note: value.notes[index],
                            ),
                          );
                        }),
                        staggeredTileBuilder: (index) =>
                            const StaggeredTile.fit(1),
                      ),
                    ],
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
    );
  }
}
