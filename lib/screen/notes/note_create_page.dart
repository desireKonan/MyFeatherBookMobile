import 'package:flutter/material.dart';
import 'package:my_feather_book_mobile/components/feather_text_field.dart';
import 'package:my_feather_book_mobile/config/database.dart';
import 'package:my_feather_book_mobile/helpers/ui_helpers.dart';
import 'package:my_feather_book_mobile/models/notes.dart';
import 'package:my_feather_book_mobile/repository/note_repository.dart';
import 'package:my_feather_book_mobile/screen/template_page.dart';
import 'package:sqflite/sqflite.dart';

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
    return TemplatePage(
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Container(
            margin: const EdgeInsets.only(top: 30.0, bottom: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /*Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  height: 50,
                  color: const Color.fromARGB(255, 85, 165, 231),
                  margin: const EdgeInsets.only(top: 0.1),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Notes - Formulaire de saisie',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 247, 244, 244),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),*/
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
                /*ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 50),
                    maximumSize: const Size(170, 75),
                    primary: const Color.fromARGB(255, 21, 174, 103),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                  ),
                  onPressed: _saveNotes,
                  child: const Text(
                    'Enregistrer',
                    style: TextStyle(
                        fontSize: 18, color: Color.fromARGB(255, 246, 248, 247)),
                  ),
                ),*/
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
