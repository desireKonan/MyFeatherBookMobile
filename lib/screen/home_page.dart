import 'package:flutter/material.dart';
import 'package:my_feather_book_mobile/components/card_notes.dart';
import 'package:my_feather_book_mobile/screen/template_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _passToScreen() {
    Navigator.pushNamed(context, '/note-form');
  }

  @override
  Widget build(BuildContext context) {
    return TemplatePage(
      content: GridView.count(
        crossAxisCount: 2,
        children: List.generate(10, (index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: NoteCard(
              index: index,
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _passToScreen,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
