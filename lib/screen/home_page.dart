import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:my_feather_book_mobile/helpers/ui_helpers.dart';
import 'package:my_feather_book_mobile/screen/feather_room/feather_room_list_page.dart';
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
    FeatherRoomListPage(),
    Center(child: Text('Page 3')),
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
        height: 100,
        decoration: const BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.5),
              topRight: Radius.circular(5.5),
            ),
            boxShadow: [
              BoxShadow(color: Colors.black87),
            ]),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.teal,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          currentIndex: _currentIndex,
          onTap: (value) => setState(() {
            _currentIndex = value;
          }),
          iconSize: 35,
          selectedFontSize: 15,
          unselectedFontSize: 13,
          items: const [
            BottomNavigationBarItem(
              label: 'Notes',
              icon: Icon(Icons.note_add, color: Colors.white60),
            ),
            BottomNavigationBarItem(
              label: 'Journal',
              icon: Icon(FeatherIcons.feather, color: Colors.white60),
            ),
            BottomNavigationBarItem(
              label: 'Objectifs',
              icon: Icon(Icons.star, color: Colors.white60),
            ),
            BottomNavigationBarItem(
              label: 'Dashboard',
              icon: Icon(Icons.pie_chart, color: Colors.white60),
            )
          ],
        ),
      ),
    );
  }
}
