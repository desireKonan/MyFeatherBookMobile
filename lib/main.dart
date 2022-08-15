import 'package:flutter/material.dart';
import 'package:my_feather_book_mobile/screen/counter_page.dart';
import 'package:my_feather_book_mobile/screen/home_page.dart';
import 'package:my_feather_book_mobile/screen/notes/note_create_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyFeatherBook',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const MyHomePage(),
        '/counter': (context) => const MyCounterPage(title: 'MyFeatherBookPage'),
        '/createNote': (context) => const NoteCreatePage(),
        //'/note': (context) => const
      },
      initialRoute: "/",
    );
  }
}
