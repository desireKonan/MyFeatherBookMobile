import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:my_feather_book_mobile/models/dto/notes.dart';
import 'package:my_feather_book_mobile/models/repository/note_repository.dart';
import 'package:my_feather_book_mobile/models/repository/repository.dart';
import 'package:my_feather_book_mobile/view/create_notes_view.dart';

class CreateNotesPresenter {
  late Repository<Notes, int> _repository;
  late CreateNotesView _view;

  CreateNotesPresenter(CreateNotesView view)
      : _repository = NoteRepository(),
        this._view = view;

  Notes get notes => _view.getNotes();

  void saveNotes() async {
    var notes = await _repository.insert(this.notes);

    log("Création $notes");

    Navigator.of(_view.context).pop();

    _view.showSnackBar("Notes ajoutée avec succès !");
  }
}
