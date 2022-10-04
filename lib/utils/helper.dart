import 'package:intl/intl.dart';
import 'string_extension.dart';
import 'package:intl/date_symbol_data_local.dart';

String getDate(DateTime date) {
  initializeDateFormatting();
  DateFormat dateFormat = DateFormat.yMMMMEEEEd('fr');
  return dateFormat.format(date).capitalize();
}
