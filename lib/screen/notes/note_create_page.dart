import 'package:flutter/material.dart';
import 'package:my_feather_book_mobile/components/feather_text_field.dart';
import 'package:my_feather_book_mobile/helpers/constants.dart';
import 'package:my_feather_book_mobile/helpers/ui_helpers.dart';
import 'package:my_feather_book_mobile/presenter/create_notes_presenter.dart';
import 'package:my_feather_book_mobile/view/create_notes_view.dart';

class NoteCreatePage extends StatefulWidget {
  const NoteCreatePage({Key? key}) : super(key: key);

  @override
  State<NoteCreatePage> createState() => _NoteCreatePageState();
}

class _NoteCreatePageState extends State<NoteCreatePage> {
  late CreateNotesView _notesView;

  late CreateNotesPresenter _createNotesPresenter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notesView = CreateNotesView(context: context);
    _createNotesPresenter = CreateNotesPresenter(_notesView);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the TemplatePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text(APP_NAME),
      ),
      drawer: buildDrawer(context),
      body: Form(
        key: _notesView.formKey,
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Container(
            margin: const EdgeInsets.only(top: 30.0, bottom: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FeatherTextField(
                  controller: _notesView.titleController,
                  labelText: 'Titre',
                ),
                const SizedBox(
                  height: 25,
                ),
                FeatherTextField(
                  controller: _notesView.contentController,
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
        onPressed: _createNotesPresenter.saveNotes,
        child: const Icon(Icons.edit),
      ),
    );
  }
}
