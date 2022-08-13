import 'package:flutter/material.dart';
import 'package:my_feather_book_mobile/helpers/constants.dart';
import 'package:my_feather_book_mobile/helpers/ui_helpers.dart';

class TemplatePage extends StatefulWidget {
  final Widget content;

  final FloatingActionButton? floatingActionButton;

  const TemplatePage(
      {Key? key, required this.content, this.floatingActionButton})
      : super(key: key);

  @override
  State<TemplatePage> createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the TemplatePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text(APP_NAME),
      ),

      drawer: buildDrawer(context),

      body: widget.content,

      floatingActionButton: widget
          .floatingActionButton, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
