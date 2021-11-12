import 'package:intl/intl.dart';

String getTimeRange(DateTime startDate, int durationInMinutes, [String delimiter = '\n']) {
  var from = DateFormat('HH:mm', 'es').format(startDate);
  var to = DateFormat('HH:mm', 'es').format(
    startDate.add(Duration(minutes: durationInMinutes)),
  );

  return '$from$delimiter$to';
}
