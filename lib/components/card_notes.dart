import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_feather_book_mobile/models/dto/notes.dart';
import 'package:my_feather_book_mobile/utils/helper.dart';

class NoteCard extends StatelessWidget {
  final Notes note;

  const NoteCard({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: const Color.fromARGB(255, 55, 55, 54),
      color: const Color.fromARGB(255, 22, 160, 130),
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: Color.fromARGB(255, 236, 95, 13),
          width: 0.2,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      elevation: 5.0,
      child: Container(
        height: 150,
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
                color: Color.fromARGB(255, 242, 237, 237),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              '${note.content}',
              style: const TextStyle(
                color: Color.fromARGB(255, 242, 237, 237),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              getDate(note.createdDate),
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w300,
                color: Color.fromARGB(255, 242, 237, 237),
              ),
            )
          ],
        ),
      ),
    );
  }
}
