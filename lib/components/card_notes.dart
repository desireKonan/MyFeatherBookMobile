import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_feather_book_mobile/models/dto/notes.dart';

class NoteCard extends StatelessWidget {
  final Notes note;

  const NoteCard({Key? key, required this.note}) : super(key: key);

  String getDate() {
    return DateFormat.yMMMMEEEEd().format(note.createdDate);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: const Color.fromARGB(255, 97, 96, 94),
      color: const Color.fromARGB(255, 244, 244, 243),
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: Color.fromARGB(255, 139, 137, 137),
          width: 0.2,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      elevation: 2.0,
      child: Container(
        height: 300,
        margin: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              '${note.title}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 122, 120, 120),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              '${note.content}',
              style: const TextStyle(
                color: Color.fromARGB(255, 122, 120, 120),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              getDate(),
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w300,
                color: Color.fromARGB(255, 122, 120, 120),
              ),
            )
          ],
        ),
      ),
    );
  }
}
