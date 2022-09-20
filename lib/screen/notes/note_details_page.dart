import 'package:flutter/material.dart';
import 'package:my_feather_book_mobile/components/custom_snackbar.dart';
import 'package:my_feather_book_mobile/components/outline_text_field.dart';
import 'package:my_feather_book_mobile/models/dto/notes.dart';
import 'package:my_feather_book_mobile/models/notifiers/note_model.dart';
import 'package:my_feather_book_mobile/presenter/notes/create_update_notes_presenter.dart';
import 'package:my_feather_book_mobile/presenter/notes/delete_notes_presenter.dart';
import 'package:my_feather_book_mobile/utils/helper.dart';
import 'package:my_feather_book_mobile/view/notes/create_notes_view.dart';
import 'package:provider/provider.dart';

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
  Notes getNotes() {
    _notes.id = 0;
    _notes.title = _titleController.text;
    _notes.content = _contentController.text;
    _notes.createdDate = DateTime.now();
    _notes.updatedDate = DateTime(0);
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
    const CustomSnackbar(text: 'Insertion effectuée avec succès !')
        .renderSnackBar(context);
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
        backgroundColor: Colors.teal,
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 1.0),
            child: Consumer<NoteModel>(
              builder: (context, value, child) => MaterialButton(
                onPressed: () {
                  _deleteNotesPresenter.deleteNote(widget.noteId!);
                  value.remove(_notes);
                },
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 1.0),
            child: MaterialButton(
              onPressed: () {
                var noteProvider = Provider.of<NoteModel>(
                  context,
                  listen: false,
                );
                if (widget.noteId is Null) {
                  _createUpdateNotesPresenter.saveNotes();
                  noteProvider.add(_notes);
                } else {
                  _createUpdateNotesPresenter.updateNotes(widget.noteId!);
                  noteProvider.update(widget.noteId!, _notes);
                }
              },
              child: const Icon(
                Icons.edit,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      );
    }
    return AppBar(
      backgroundColor: Colors.teal,
      actions: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 1.0),
          child: MaterialButton(
            onPressed: () {
              var noteProvider = Provider.of<NoteModel>(context, listen: false);
              if (widget.noteId is Null) {
                _createUpdateNotesPresenter.saveNotes();
                noteProvider.add(_notes);
              } else {
                _createUpdateNotesPresenter.updateNotes(widget.noteId!);
                noteProvider.update(widget.noteId!, _notes);
              }
            },
            child: const Icon(
              Icons.edit,
              color: Colors.white70,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppHeader(),
      body: Container(
        margin: const EdgeInsets.only(top: 15.5, bottom: 15.5),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              OutlineTextField(
                controller: _titleController,
                labelText: 'Titre',
              ),
              const SizedBox(
                height: 25,
              ),
              OutlineTextField(
                controller: _contentController,
                labelText: 'Description',
                maxLine: 22,
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    const Text(
                      'Créée le ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text(
                      getDate(_notes.createdDate),
                      style: const TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 15),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    const Text(
                      'Mis à jour le ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text(
                      getDate(_notes.updatedDate),
                      style: const TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 15),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
