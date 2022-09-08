import 'package:flutter/cupertino.dart';
import 'package:my_feather_book_mobile/models/dto/notes.dart';
import 'package:my_feather_book_mobile/models/repository/note_repository.dart';
import 'package:my_feather_book_mobile/models/repository/repository.dart';
import 'package:my_feather_book_mobile/view/notes/create_notes_view.dart';

class CreateUpdateNotesPresenter {
  late Repository<Notes, int> _repository;
  late CreateUpdateNotesView _view;

  final message = "Notes ajoutée avec succès !";

  CreateUpdateNotesPresenter(CreateUpdateNotesView view)
      : _repository = NoteRepository(),
        this._view = view;

  Notes get notes => _view.getNotes();

  Future<Notes> getNotes(int id) async {
    Notes notes = await _repository.getData(id);
    return notes;
  }

  void saveNotes() async {
    Notes notes = await _repository.insert(this.notes);
    _view.showSnackBar(message);

    _view.move();
  }

  void updateNotes(int id) async {
    Notes notes = await _repository.update(id, this.notes);
    _view.showSnackBar(message);
  }
}
