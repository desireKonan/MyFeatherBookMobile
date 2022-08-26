import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:my_feather_book_mobile/models/dto/notes.dart';
import 'package:my_feather_book_mobile/models/repository/note_repository.dart';
import 'package:my_feather_book_mobile/models/repository/repository.dart';
import 'package:my_feather_book_mobile/view/feather_room/create_feather_room_view.dart';
import 'package:my_feather_book_mobile/view/notes/create_notes_view.dart';

class DeleteFeatherRoomPresenter {
  late Repository<Notes, int> _repository;
  late CreateUpdateFeatherRoomView _view;

  final _message = "Notes du journal de bord supprimé avec succès !";

  DeleteFeatherRoomPresenter(CreateUpdateFeatherRoomView view)
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
