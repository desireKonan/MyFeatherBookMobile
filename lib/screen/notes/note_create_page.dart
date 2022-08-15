import 'package:flutter/material.dart';
import 'package:my_feather_book_mobile/components/feather_text_field.dart';
import 'package:my_feather_book_mobile/helpers/constants.dart';
import 'package:my_feather_book_mobile/models/notes.dart';
import 'package:my_feather_book_mobile/repository/note_repository.dart';

class NoteCreatePage extends StatefulWidget {
  const NoteCreatePage({Key? key}) : super(key: key);

  @override
  State<NoteCreatePage> createState() => _NoteCreatePageState();
}

class _NoteCreatePageState extends State<NoteCreatePage> {
  //Clé du formulaire.
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();

  final _contentController = TextEditingController();

  final _noteRepository = NoteRepository();

  var _isInserted = false;

  void _saveNotes() async {
    var note = Notes(
      id: 0,
      title: _titleController.text,
      content: _contentController.text,
      createdDate: DateTime.now(),
      updatedDate: DateTime(0),
    );

    print(note.toString());

    var notes = await _noteRepository.insert(note);

    print("Effectué ! Voici les notes : $notes");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the TemplatePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text(APP_NAME),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Container(
            margin: const EdgeInsets.only(top: 30.0, bottom: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FeatherTextField(
                  controller: _titleController,
                  labelText: 'Titre',
                ),
                const SizedBox(
                  height: 25,
                ),
                FeatherTextField(
                  controller: _contentController,
                  labelText: 'Description',
                  maxLine: 22,
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveNotes,
        child: const Icon(Icons.edit),
      ),
    );
  }
}
