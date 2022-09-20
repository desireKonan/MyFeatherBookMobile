import 'package:flutter/cupertino.dart';
import 'package:my_feather_book_mobile/models/dto/notes.dart';
import 'package:my_feather_book_mobile/models/repository/note_repository.dart';
import 'package:my_feather_book_mobile/models/repository/repository.dart';
import 'package:my_feather_book_mobile/view/feather_room/create_feather_room_view.dart';

class CreateUpdateFeatherRoomPresenter {
  late Repository<Notes, int> _repository;
  late CreateUpdateFeatherRoomView _view;

  final _MESSAGE = "Notes du journal de bord ajoutée avec succès !";

  CreateUpdateFeatherRoomPresenter(CreateUpdateFeatherRoomView view)
      : _repository = NoteRepository(),
        this._view = view;

  Notes get notes => _view.getNotes();

  Future<Notes> getNotes(int id) async {
    Notes notes = await _repository.getData(id);
    return notes;
  }

  void saveNotes() async {
    Notes notes = await _repository.insert(this.notes);

    Navigator.of(_view.getContext()).pop();

    _view.showSnackBar(_MESSAGE);
  }

  void updateNotes(int id) async {
    Notes notes = await _repository.update(id, this.notes);

    Navigator.of(_view.getContext()).pop();

    _view.showSnackBar(_MESSAGE);
  }
}
