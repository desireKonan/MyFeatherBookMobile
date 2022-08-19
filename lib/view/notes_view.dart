import 'package:flutter/cupertino.dart';
import 'package:my_feather_book_mobile/models/dto/notes.dart';
import 'package:my_feather_book_mobile/view/view.dart';

class NotesView implements View {
  late List<Notes> _notes;

  late BuildContext context;

  String route = "/createNote";

  NotesView({required this.context}) : _notes = List.empty();

  List<Notes> get notes => _notes;

  set notes(List<Notes> notes) => _notes = notes;

  @override
  void move() {
    Navigator.of(context).pushNamed(route);
  }
}
