import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:my_feather_book_mobile/models/notifiers/daily_bord_model.dart';
import 'package:my_feather_book_mobile/models/notifiers/note_model.dart';
import 'package:my_feather_book_mobile/screen/home_page.dart';
import 'package:my_feather_book_mobile/screen/notes/note_details_page.dart';
import 'package:my_feather_book_mobile/screen/notes/note_list_page.dart';
import 'package:provider/provider.dart';

void main() {
  initializeDateFormatting().then(
    (_) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => NoteModel(),
          ),
          ChangeNotifierProvider(
            create: (_) => DailyBoardModel(),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
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
        '/': (context) => const FeatherRoomHomePage(),
        'noteList': (context) => const NoteListPage(),
        //'/counter': (context) => const MyCounterPage(title: 'MyFeatherBookPage'),
        '/createNote': (context) => const NoteDetailsPage(),
      },
      initialRoute: "/",
    );
  }
}
