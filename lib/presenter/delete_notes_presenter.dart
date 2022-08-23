import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:my_feather_book_mobile/models/dto/notes.dart';
import 'package:my_feather_book_mobile/models/repository/note_repository.dart';
import 'package:my_feather_book_mobile/models/repository/repository.dart';
import 'package:my_feather_book_mobile/view/create_notes_view.dart';

class DeleteNotesPresenter {
  late Repository<Notes, int> _repository;
  late CreateUpdateNotesView _view;

  final _message = "Notes supprimé avec succès !";

  DeleteNotesPresenter(CreateUpdateNotesView view)
      : _repository = NoteRepository(),
        this._view = view;

  Notes get notes => _view.getNotes();

  Future<Notes> getNotes(int id) async {
    Notes notes = await _repository.getData(id);
    return notes;
  }

  void deleteNote(int id) async {
    _repository.deleteData(id);

    Navigator.of(_view.getContext()).pop();

    _view.showSnackBar(_message);
  }
}
