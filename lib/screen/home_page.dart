import 'package:flutter/material.dart';
import 'package:my_feather_book_mobile/components/card_notes.dart';
import 'package:my_feather_book_mobile/models/notes.dart';
import 'package:my_feather_book_mobile/repository/note_repository.dart';
import 'package:my_feather_book_mobile/screen/template_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Notes> _notes;
  var _loading = false;

  var _noteRepository = NoteRepository();

  void _passToScreen() {
    Navigator.of(context).pushNamed('/createNote');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<List<Notes>> _getNotes() async {
    _notes = await _noteRepository.getAll();
    return _notes;
  }

  @override
  Widget build(BuildContext context) {
    return TemplatePage(
      content: FutureBuilder(
          initialData: List<Notes>.empty,
          future: _getNotes(),
          builder: (buildContext, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator(
                color: Colors.blueAccent,
              );
            } else {
              return ListView.builder(
                itemCount: _notes.length,
                itemBuilder: (context, index) => NoteCard(
                  note: _notes[index],
                ),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _passToScreen,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
