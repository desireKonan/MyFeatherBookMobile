import 'package:flutter/material.dart';
import 'package:my_feather_book_mobile/components/custom_snackbar.dart';
import 'package:my_feather_book_mobile/components/outline_text_field.dart';
import 'package:my_feather_book_mobile/models/dto/notes.dart';
import 'package:my_feather_book_mobile/presenter/feather_room/create_update_feather_room_presenter.dart';
import 'package:my_feather_book_mobile/presenter/feather_room/delete_feather_room_presenter.dart';
import 'package:my_feather_book_mobile/view/feather_room/create_feather_room_view.dart';

class FeatherRoomDetailsPage extends StatefulWidget {
  final int? noteId;

  const FeatherRoomDetailsPage({Key? key, this.noteId}) : super(key: key);

  @override
  State<FeatherRoomDetailsPage> createState() => _FeatherRoomDetailsPageState();
}

class _FeatherRoomDetailsPageState extends State<FeatherRoomDetailsPage>
    implements CreateUpdateFeatherRoomView {
  //Clé du formulaire.
  late GlobalKey<FormState> _formKey;

  late TextEditingController _titleController;

  late TextEditingController _contentController;

  late Notes _notes;

  late CreateUpdateFeatherRoomPresenter _createUpdateNotesPresenter;

  late DeleteFeatherRoomPresenter _deleteNotesPresenter;

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
    _createUpdateNotesPresenter = CreateUpdateFeatherRoomPresenter(this);
    _deleteNotesPresenter = DeleteFeatherRoomPresenter(this);

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
    return AppBar(
      backgroundColor: Colors.teal,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppHeader(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Container(
            margin: const EdgeInsets.only(top: 15.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          if (widget.noteId is Null)
            _createUpdateNotesPresenter.saveNotes();
          else
            _createUpdateNotesPresenter.updateNotes(widget.noteId!);
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
