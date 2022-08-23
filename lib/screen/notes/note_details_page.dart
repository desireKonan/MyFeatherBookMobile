import 'package:flutter/material.dart';
import 'package:my_feather_book_mobile/components/feather_text_field.dart';
import 'package:my_feather_book_mobile/helpers/ui_helpers.dart';
import 'package:my_feather_book_mobile/models/dto/notes.dart';
import 'package:my_feather_book_mobile/presenter/create_update_notes_presenter.dart';
import 'package:my_feather_book_mobile/presenter/delete_notes_presenter.dart';
import 'package:my_feather_book_mobile/view/create_notes_view.dart';

class NoteDetailsPage extends StatefulWidget {
  final int? noteId;

  const NoteDetailsPage({Key? key, this.noteId}) : super(key: key);

  @override
  State<NoteDetailsPage> createState() => _NoteDetailsPageState();
}

class _NoteDetailsPageState extends State<NoteDetailsPage>
    implements CreateUpdateNotesView {
  //Clé du formulaire.
  late GlobalKey<FormState> _formKey;

  late TextEditingController _titleController;

  late TextEditingController _contentController;

  late Notes _notes;

  late CreateUpdateNotesPresenter _createUpdateNotesPresenter;

  late DeleteNotesPresenter _deleteNotesPresenter;

  bool _loading = false;

  bool _isInsertedMode = true;

  @override
  String route = "/";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _formKey = GlobalKey<FormState>();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
    _notes = Notes.init();
    _createUpdateNotesPresenter = CreateUpdateNotesPresenter(this);
    _deleteNotesPresenter = DeleteNotesPresenter(this);

    //Chargement du détails.
    if (!(widget.noteId is Null)) {
      _getNotes(widget.noteId!).then((value) {
        _titleController.text = value.title;
        _contentController.text = value.content;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Notes getNotes() {
    if (widget.noteId is Null) {
      _notes.id = 0;
      _notes.title = _titleController.text;
      _notes.content = _contentController.text;
      _notes.createdDate = DateTime.now();
      _notes.updatedDate = DateTime(0);
    }
    return _notes;
  }

  Future<Notes> _getNotes(int id) async {
    //Partie de chargement des données.
    setState(() {
      _loading = true;
    });
    _notes = await _createUpdateNotesPresenter.getNotes(id);
    setState(() {
      _loading = false;
      _isInsertedMode = false;
    });
    return _notes;
  }

  @override
  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Insertion effectuée avec succès !'),
      ),
    );
  }

  @override
  BuildContext getContext() => context;

  @override
  void move() {
    Navigator.of(context).pop();
  }

  AppBar buildAppHeader() {
    if (!_isInsertedMode) {
      return AppBar(
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 1.0),
            child: MaterialButton(
              onPressed: () => _deleteNotesPresenter.deleteNote(widget.noteId!),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    }
    return AppBar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppHeader(),
      drawer: buildDrawer(context),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Container(
            margin: const EdgeInsets.only(top: 30.0, bottom: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FeatherTextField(
                  controller: _titleController,
                  labelText: 'Titre',
                ),
                const SizedBox(
                  height: 25,
                ),
                FeatherTextField(
                  controller: _contentController,
                  labelText: 'Description',
                  maxLine: 22,
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createUpdateNotesPresenter.saveNotes(widget.noteId!),
        child: const Icon(Icons.edit),
      ),
    );
  }
}
