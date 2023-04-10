import 'package:dpmaker/Localization/LocalizationService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


///  all the extensions that are used in app is declared in this file.

extension StringExtension on String {
  String toLocalized(BuildContext context) =>
      LocalizationService.of(context)!.translate(this);

  /// Convert DateString to DateTime Object
  DateTime? toDate() {
    try {
      final DateTime st = DateTime.parse(this);
      return st;
      // ignore: unused_catch_clause
    } on FormatException catch (e) {
      return null;
    }
  }

}

extension BoolExtension on bool {
  bool toggle() => !this;
}

extension DateExt on DateTime {

  String get dayFormat  => DateFormat('MMM d, yy').format(this);
  String get dateFormat => DateFormat('dd/MM/yy').format(this);
  String get timeFormat => DateFormat('kk:ss aa').format(this);

}

extension ContextExtensions on BuildContext {
  /// Returns The state from the closest instance of this class that encloses the given context.
  ///
  /// It is used for showing widgets on top of everything.
  ///
  OverlayState? get overlay => Overlay.of(this);

  ///
  /// Insert the given widget into the overlay.
  /// The newly inserted widget will always be at the top.
  ///
  OverlayEntry addOverlay(WidgetBuilder builder) {
    final entry = OverlayEntry(builder: builder);
    overlay!.insert(entry);
    return entry;
  }
}


extension on int {

  /// Leaves given height of space
  Widget get heightBox => SizedBox(height: toDouble());

  /// Leaves given width of space
  Widget get widthBox => SizedBox(width: toDouble());

  // return suffix (th,st,nd,rd) of the given month day number
  String toMonthDaySuffix() {
    if (!(this >= 1 && this <= 31)) {
      throw Exception('Invalid day of month');
    }

    if (this >= 11 && this <= 13) {
      return '$this th';
    }

    switch (this % 10) {
      case 1:
        return '$this st';
      case 2:
        return '$this nd';
      case 3:
        return '$this rd';
      default:
        return '$this th';
    }
  }

  // returns month name from the given int
  String toMonthName({bool isHalfName = false}) {
    String status = '';
    if (!(this >= 1 && this <= 12)) {
      throw Exception('Invalid day of month');
    }
    if (this == 1) {
      return status = isHalfName ? 'Jan' : 'January';
    } else if (this == 2) {
      return status = isHalfName ? 'Feb' : 'February';
    } else if (this == 3) {
      return status = isHalfName ? 'Mar' : 'March';
    } else if (this == 4) {
      return status = isHalfName ? 'Apr' : 'April';
    } else if (this == 5) {
      return status = isHalfName ? 'May' : 'May';
    } else if (this == 6) {
      return status = isHalfName ? 'Jun' : 'June';
    } else if (this == 7) {
      return status = isHalfName ? 'Jul' : 'July';
    } else if (this == 8) {
      return status = isHalfName ? 'Aug' : 'August';
    } else if (this == 9) {
      return status = isHalfName ? 'Sept' : 'September';
    } else if (this == 10) {
      return status = isHalfName ? 'Oct' : 'October';
    } else if (this == 11) {
      return status = isHalfName ? 'Nov' : 'November';
    } else if (this == 12) {
      return status = isHalfName ? 'Dec' : 'December';
    }
    return status;
  }

  // returns WeekDay from the given int
  String toWeekDay({bool isHalfName = false}) {
    if (!(this >= 1 && this <= 7)) {
      throw Exception('Invalid day of month');
    }
    String weekName = '';

    if (this == 1) {
      return weekName = isHalfName ? "Mon" : "Monday";
    } else if (this == 2) {
      return weekName = isHalfName ? "Tue" : "Tuesday";
    } else if (this == 3) {
      return weekName = isHalfName ? "Wed" : "Wednesday";
    } else if (this == 4) {
      return weekName = isHalfName ? "Thu" : "Thursday";
    } else if (this == 5) {
      return weekName = isHalfName ? "Fri" : "Friday";
    } else if (this == 6) {
      return weekName = isHalfName ? "Sat" : "Saturday";
    } else if (this == 7) {
      return weekName = isHalfName ? "Sun" : "Sunday";
    }
    return weekName;
  }
}

