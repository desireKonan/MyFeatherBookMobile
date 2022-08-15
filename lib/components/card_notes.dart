import 'package:flutter/material.dart';
import 'package:my_feather_book_mobile/models/notes.dart';

class NoteCard extends StatelessWidget {
  final Notes note;

  const NoteCard({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: const Color.fromARGB(255, 97, 96, 94),
      color: const Color.fromARGB(255, 133, 132, 128),
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(70.0),
        ),
      ),
      child: SizedBox(
        width: 150,
        height: 300,
        child: Text(
          '${note.content}',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
