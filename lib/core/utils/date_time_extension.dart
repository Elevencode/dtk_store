import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  bool get isToday => toLocal().isAtSameDayAs(today());

  bool get isBeforeToday => toLocal().isBefore(today());

  bool get isAfterToday => toLocal().isAfter(
        today()
            .add(const Duration(days: 1))
            .subtract(const Duration(milliseconds: 1)),
      );

  bool isAtSameDayAs(DateTime compare) {
    var local = compare.toLocal();
    return DateTime(year, month, day).isAtSameMomentAs(
      DateTime(local.year, local.month, local.day),
    );
  }

  /// Parses the date and sets the local time zone.
  DateTime get withLocalTimeZone {
    var timezoneOffset = int.parse(
      DateTime.now().timeZoneOffset.toString().split(':').first,
    );

    var timezone = timezoneOffset >= 0
        ? '+${timezoneOffset.toString().padLeft(2, '0')}'
        : '-${(-timezoneOffset).toString().padLeft(2, '0')}';

    // var timeRange = selectedTimeValue.split(",");

    var dateTimeWithTimeZone = DateTime.parse(
      "${DateFormat('yyyy-MM-dd HH:mm').format(this)}$timezone",
    );
    return dateTimeWithTimeZone;
  }
}

DateTime today() {
  var now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
}
