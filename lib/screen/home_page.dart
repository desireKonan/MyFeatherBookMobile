import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:my_feather_book_mobile/helpers/ui_helpers.dart';
import 'package:my_feather_book_mobile/screen/notes/note_list_page.dart';

class FeatherRoomHomePage extends StatefulWidget {
  const FeatherRoomHomePage({Key? key}) : super(key: key);

  @override
  State<FeatherRoomHomePage> createState() => _FeatherRoomPageState();
}

class _FeatherRoomPageState extends State<FeatherRoomHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      animationDuration: const Duration(milliseconds: 150),
      child: Scaffold(
        appBar: AppBar(
          // Here we take the value from the TemplatePage object that was created by
          // the App.build method, and use it to set our appbar title.
          //title: const Text(APP_NAME),
          backgroundColor: Colors.teal,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Notes',
                icon: Icon(Icons.note, color: Colors.white),
                height: 100,
              ),
              Tab(
                text: 'Objectifs personnels',
                icon: Icon(FeatherIcons.activity, color: Colors.white),
                height: 100,
              ),
              Tab(
                text: 'Feather room',
                icon: Icon(FeatherIcons.feather, color: Colors.white),
                height: 100,
              ),
              Tab(
                text: 'Tableau de bord',
                icon: Icon(Icons.pie_chart, color: Colors.white),
                height: 100,
              ),
            ],
          ),
        ),
        drawer: buildDrawer(context),
        body: TabBarView(
          //controller: ,
          children: const [
            NoteListPage(),
            Center(child: Text('Page 2')),
            Center(child: Text('Page 3')),
            Center(child: Text('Page 4'))
          ],
        ),
      ),
    );
  }
}
