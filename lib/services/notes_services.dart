import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_feather_book_mobile/models/notes.dart';
import 'package:my_feather_book_mobile/repository/note_repository.dart';

class NotesService {
  late final NoteRepository _noteRepository;

  late List<Notes> _notes;

  NotesService()
      : _noteRepository = NoteRepository(),
        _notes = List.empty();

  List<Notes> get notes => _notes;

  NoteRepository get noteRepository => _noteRepository;

  Future<List<Notes>> getNotes() async {
    _notes = await _noteRepository.getAll();
    return _notes;
  }

  void saveNotes(Notes data, BuildContext context) async {
    var notes = await _noteRepository.insert(data);

    log("Création $notes");

    Navigator.of(context).pop();
  }
}
