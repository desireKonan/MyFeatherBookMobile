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
  int _currentIndex = 0;

  List<Widget> _screens = [
    NoteListPage(),
    Center(child: Text('Page 2')),
    FeatherRoomHomePage(),
    Center(child: Text('Page 4'))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the TemplatePage object that was created by
        // the App.build method, and use it to set our appbar title.
        //title: const Text(APP_NAME),
        backgroundColor: Colors.teal,
      ),
      drawer: buildDrawer(context),
      body: IndexedStack(
        sizing: StackFit.passthrough,
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(color: Colors.teal),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.teal,
          selectedItemColor: Colors.white70,
          unselectedItemColor: Colors.white60,
          currentIndex: _currentIndex,
          onTap: (value) => setState(() {
            _currentIndex = value;
          }),
          iconSize: 25,
          selectedFontSize: 15,
          unselectedFontSize: 10,
          items: const [
            BottomNavigationBarItem(
              label: 'Notes',
              icon: Icon(Icons.note, color: Colors.white54),
            ),
            BottomNavigationBarItem(
              label: 'Objectifs personnels',
              icon: Icon(FeatherIcons.activity, color: Colors.white54),
            ),
            BottomNavigationBarItem(
              label: 'Feather room',
              icon: Icon(FeatherIcons.feather, color: Colors.white54),
            ),
            BottomNavigationBarItem(
              label: 'Tableau de bord',
              icon: Icon(Icons.pie_chart, color: Colors.white54),
            )
          ],
        ),
      ),
    );
  }
}
