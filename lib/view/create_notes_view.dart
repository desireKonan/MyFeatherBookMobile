import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_feather_book_mobile/models/dto/notes.dart';
import 'package:my_feather_book_mobile/view/view.dart';

class CreateNotesView implements View {
  //Clé du formulaire.
  late GlobalKey<FormState> _formKey;

  late TextEditingController _titleController;

  late TextEditingController _contentController;

  late Notes _notes;

  BuildContext context;

  String route = "/";

  CreateNotesView({required this.context})
      : _formKey = GlobalKey<FormState>(),
        _titleController = TextEditingController(),
        _contentController = TextEditingController(),
        _notes = Notes.init();

  GlobalKey<FormState> get formKey => _formKey;

  TextEditingController get titleController => _titleController;

  TextEditingController get contentController => _contentController;

  Notes getNotes() {
    _notes.id = 0;
    _notes.title = _titleController.text;
    _notes.content = _contentController.text;
    _notes.createdDate = DateTime.now();
    _notes.updatedDate = DateTime(0);
    return _notes;
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Insertion effectuée avec succès !'),
      ),
    );
  }

  @override
  void move() {
    Navigator.of(context).pop();
  }
}
