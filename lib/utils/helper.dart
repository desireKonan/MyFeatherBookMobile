import 'package:intl/intl.dart';

String getDate(DateTime date) {
  return DateFormat.yMMMMEEEEd().format(date);
}
