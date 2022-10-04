import 'package:flutter/material.dart';
import 'package:my_feather_book_mobile/components/my_feather_transition_page.dart';
import 'package:my_feather_book_mobile/models/dto/diary.dart';
import 'package:my_feather_book_mobile/models/dto/event.dart';
import 'package:my_feather_book_mobile/models/notifiers/daily_bord_model.dart';
import 'package:my_feather_book_mobile/presenter/feather_room/list_feather_room_presenter.dart';
import 'package:my_feather_book_mobile/screen/feather_room/feather_room_details_page.dart';
import 'package:my_feather_book_mobile/view/feather_room/feather_room_view.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class FeatherRoomListPage extends StatefulWidget {
  const FeatherRoomListPage({Key? key}) : super(key: key);

  @override
  State<FeatherRoomListPage> createState() => _FeatherRoomListPageState();
}

class _FeatherRoomListPageState extends State<FeatherRoomListPage>
    implements FeatherRoomView {
  String route = "/createDiary";

  late ListFeatherRoomPresenter _presenter;

  late DailyBoardModel _dailyNotesModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _presenter = ListFeatherRoomPresenter(this);
    _presenter.fetchDailyNotes();
  }

  @override
  void loadDailyNotesOnView(List<Diary> dailyNotes) {
    _dailyNotesModel = Provider.of<DailyBoardModel>(context, listen: false);
    _dailyNotesModel.newNotes = dailyNotes;
    print(_dailyNotesModel.notes);
  }

  @override
  void move() {
    Navigator.of(context).pushNamed(route);
  }

  List<Event> _getEventsForDay(List<Diary> dailyNotes, DateTime dateTime) {
    List<Event> events = dailyNotes
        .takeWhile((value) => dateTime.compareTo(value.createdDate) == 0)
        .map((e) => Event(title: e.title))
        .toList();
    return events;
  }

  void _moveToDailyBoardDetails(int index, Map<String, dynamic> dates) {
    Navigator.of(context).push(
      MyFeatherTransitionPage(
        child: FeatherRoomDetailsPage(
          noteId: index,
          dates: dates,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DailyBoardModel>(
      builder: (context, value, child) => RefreshIndicator(
        onRefresh: _presenter.fetchDailyNotes,
        child: FutureBuilder(
            initialData: value.notes,
            future: _presenter.getDailyNotes(),
            builder: (buildContext, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}',
                        style: const TextStyle(backgroundColor: Colors.teal)),
                  );
                }
                //Grid view concernant les informations
                return ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Journal de bord",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.teal,
                              shadows: [
                                Shadow(),
                              ]),
                        )
                      ],
                    ),
                    TableCalendar(
                      focusedDay: DateTime.now(),
                      firstDay: DateTime.utc(2010, 1, 1),
                      lastDay: DateTime.utc(2045, 12, 31),
                      eventLoader: (dateTime) {
                        return _getEventsForDay(value.notes, dateTime);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        //Récupéré la note associée à l'Evenement.
                        int id =
                            _getEventsForDay(value.notes, selectedDay).isEmpty
                                ? 0
                                : value.notes
                                    .takeWhile((note) =>
                                        _getEventsForDay(
                                                value.notes, selectedDay)[0]
                                            .title ==
                                        note.title)
                                    .toList()[0]
                                    .id;
                        _moveToDailyBoardDetails(
                            id, {'selectedDate': selectedDay});
                      },
                    ),
                  ],
                );
              }
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.teal,
                ),
              );
            }),
      ),
    );
  }
}
