import 'package:flutter/material.dart';
import 'package:my_feather_book_mobile/models/notes.dart';
import 'package:my_feather_book_mobile/repository/note_repository.dart';
import 'package:my_feather_book_mobile/screen/template_page.dart';

class NoteFormPage extends StatefulWidget {
  const NoteFormPage({Key? key}) : super(key: key);

  @override
  State<NoteFormPage> createState() => _NoteFormPageState();
}

class _NoteFormPageState extends State<NoteFormPage> {
  //Clé du formulaire.
  final _formKey = GlobalKey<FormState>();

  final _notes = Notes.init();

  final _titleController = TextEditingController();

  final _contentController = TextEditingController();

  final _noteRepository = NoteRepository();

  var _isInserted = false;

  void _saveNotes() async {
    _notes.title = _titleController.text;
    _notes.content = _contentController.text;

    setState(() {
      _isInserted = false;
    });

    await _noteRepository.insert(_notes);

    setState(() {
      _isInserted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TemplatePage(
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
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
              ),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  label: Text(
                    'Titre',
                    style: TextStyle(
                        fontSize: 17, color: Color.fromARGB(255, 21, 174, 103)),
                  ),
                ),
                onTap: () {},
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(
                  label: Text(
                    'Description',
                    style: TextStyle(
                        fontSize: 17, color: Color.fromARGB(255, 21, 174, 103)),
                  ),
                ),
                maxLines: 18,
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
