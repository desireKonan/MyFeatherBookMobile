import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final int index;

  const NoteCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(10.5),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 122, 144, 240),
        borderRadius: BorderRadius.circular(5.0),
      ),
      width: 400,
      height: 700,
      child: Center(
        child: Text(
          'Text ' + index.toString(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
